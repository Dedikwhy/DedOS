#include "keyboard.h"
#include "io.h"

// Scancode set 1, US-раскладка.
static const char SC_LOWER[] = {
    0, 27, '1','2','3','4','5','6','7','8','9','0','-','=', '\b',
    '\t','q','w','e','r','t','y','u','i','o','p','[',']','\n',
    0, 'a','s','d','f','g','h','j','k','l',';','\'','`',
    0, '\\','z','x','c','v','b','n','m',',','.','/', 0, '*',
    0, ' '
};
static const char SC_UPPER[] = {
    0, 27, '!','@','#','$','%','^','&','*','(',')','_','+', '\b',
    '\t','Q','W','E','R','T','Y','U','I','O','P','{','}','\n',
    0, 'A','S','D','F','G','H','J','K','L',':','"','~',
    0, '|','Z','X','C','V','B','N','M','<','>','?', 0, '*',
    0, ' '
};
// Цифровой блок (без E0), считаем что NumLock включён: 0x47..0x53
static const char SC_KEYPAD[] = { '7','8','9','-','4','5','6','+','1','2','3','0','.' };

#define QSIZE 32
static key_event_t s_q[QSIZE];
static int s_head, s_tail;

static int s_shift, s_ctrl, s_alt, s_caps;
static int s_ext;          // предыдущий байт был 0xE0
static int s_skip;         // хвост последовательности Pause (0xE1 ...)

static void push(uint16_t key) {
    int next = (s_head + 1) % QSIZE;
    if (next == s_tail) return;                     // очередь полна - роняем
    uint8_t mods = (uint8_t)((s_shift ? MOD_SHIFT : 0) | (s_ctrl ? MOD_CTRL : 0) | (s_alt ? MOD_ALT : 0));
    s_q[s_head].key = key;
    s_q[s_head].mods = mods;
    s_head = next;
}

static void wait_input_empty(void) {
    for (int i = 0; i < 100000 && (inb(0x64) & 0x02); i++) {}
}

static void update_leds(void) {
    wait_input_empty(); outb(0x60, 0xED);
    wait_input_empty(); outb(0x60, s_caps ? 0x04 : 0x00);
}

void kbd_init(void) {
    s_head = s_tail = 0;
    s_shift = s_ctrl = s_alt = s_caps = s_ext = s_skip = 0;
    // сбрасываем всё, что осталось в буфере контроллера после GRUB
    for (int i = 0; i < 32 && (inb(0x64) & 0x01); i++) inb(0x60);
}

int kbd_pop(key_event_t *ev) {
    if (s_head == s_tail) return 0;
    *ev = s_q[s_tail];
    s_tail = (s_tail + 1) % QSIZE;
    return 1;
}

void kbd_feed(uint8_t sc) {
    if (s_skip) { s_skip--; return; }
    if (sc == 0xE1) { s_skip = 5; return; }
    if (sc == 0xE0) { s_ext = 1; return; }
    if (sc == 0xFA || sc == 0xFE) return;                   // ACK / resend от LED-команды

    int ext = s_ext;
    s_ext = 0;
    int release = sc & 0x80;
    uint8_t code = sc & 0x7F;

    // модификаторы
    if (code == 0x2A || code == 0x36) { if (!ext) s_shift = !release; return; }  // E0 2A - «фальшивый» Shift
    if (code == 0x1D) { s_ctrl = !release; return; }
    if (code == 0x38) { s_alt = !release; return; }
    if (release) return;

    if (code == 0x3A && !ext) { s_caps = !s_caps; update_leds(); return; }

    if (ext) {
        switch (code) {
        case 0x48: push(KEY_UP); break;
        case 0x50: push(KEY_DOWN); break;
        case 0x4B: push(KEY_LEFT); break;
        case 0x4D: push(KEY_RIGHT); break;
        case 0x47: push(KEY_HOME); break;
        case 0x4F: push(KEY_END); break;
        case 0x49: push(KEY_PGUP); break;
        case 0x51: push(KEY_PGDN); break;
        case 0x52: push(KEY_INSERT); break;
        case 0x53: push(KEY_DELETE); break;
        case 0x5B: case 0x5C: push(KEY_SUPER); break;
        case 0x1C: push('\n'); break;                 // Enter цифрового блока
        case 0x35: push('/'); break;                  // «/» цифрового блока
        }
        return;
    }

    if (code >= 0x3B && code <= 0x44) { push((uint16_t)(KEY_F1 + (code - 0x3B))); return; }
    if (code == 0x57) { push(KEY_F11); return; }
    if (code == 0x58) { push(KEY_F12); return; }
    if (code >= 0x47 && code <= 0x53) { push((uint16_t)SC_KEYPAD[code - 0x47]); return; }

    if (code >= sizeof(SC_LOWER)) return;
    char c = s_shift ? SC_UPPER[code] : SC_LOWER[code];
    if (!c) return;

    int is_letter = (SC_LOWER[code] >= 'a' && SC_LOWER[code] <= 'z');
    if (is_letter) {
        if (s_ctrl) c = SC_LOWER[code];               // Ctrl+буква всегда строчная
        else if (s_caps) c = s_shift ? SC_LOWER[code] : SC_UPPER[code];
    }
    push((uint16_t)(unsigned char)c);
}
