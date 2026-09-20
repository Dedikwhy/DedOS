#include "mouse.h"
#include "io.h"

#define PORT_DATA   0x60
#define PORT_STATUS 0x64
#define PORT_CMD    0x64

static int wait_write(void) {
    for (uint32_t t = 0; t < 100000; t++) if (!(inb(PORT_STATUS) & 0x02)) return 1;
    return 0;
}

static int read_byte(void) {
    for (uint32_t t = 0; t < 200000; t++) if (inb(PORT_STATUS) & 0x01) return inb(PORT_DATA);
    return -1;
}

static void write_mouse(uint8_t b) {
    wait_write(); outb(PORT_CMD, 0xD4);
    wait_write(); outb(PORT_DATA, b);
}

// команда мыши + ожидание ACK (0xFA)
static int cmd(uint8_t b) {
    write_mouse(b);
    return read_byte() == 0xFA;
}

#define QSIZE 64
static mouse_event_t s_q[QSIZE];
static int s_head, s_tail;

static uint8_t s_pkt[4];
static int s_idx;
static int s_pkt_len = 3;

static int s_x, s_y, s_w, s_h;
static int s_buttons;

void mouse_init(int screen_w, int screen_h) {
    s_w = screen_w; s_h = screen_h;
    s_x = screen_w / 2; s_y = screen_h / 2;
    s_head = s_tail = s_idx = 0;
    s_buttons = 0;

    for (int i = 0; i < 32 && (inb(PORT_STATUS) & 0x01); i++) inb(PORT_DATA);

    wait_write(); outb(PORT_CMD, 0xA8);              // включить aux-порт
    wait_write(); outb(PORT_CMD, 0x20);              // прочитать command byte
    int status = read_byte();
    if (status < 0) status = 0x47;
    status |= 0x02;                                  // IRQ12 разрешён (мы всё равно опрашиваем)
    status &= ~0x20;                                 // тактирование aux включено
    wait_write(); outb(PORT_CMD, 0x60);
    wait_write(); outb(PORT_DATA, (uint8_t)status);

    cmd(0xF6);                                       // значения по умолчанию

    // магия IntelliMouse: sample rate 200, 100, 80 -> ID 3 = есть колесо
    static const uint8_t magic[3] = { 200, 100, 80 };
    for (int i = 0; i < 3; i++) { cmd(0xF3); cmd(magic[i]); }
    write_mouse(0xF2);
    if (read_byte() == 0xFA && read_byte() == 3) s_pkt_len = 4;

    cmd(0xF4);                                       // включить поток пакетов
}

static void push(int dz) {
    int next = (s_head + 1) % QSIZE;
    if (next == s_tail) return;
    s_q[s_head].x = s_x;
    s_q[s_head].y = s_y;
    s_q[s_head].buttons = s_buttons;
    s_q[s_head].dz = dz;
    s_head = next;
}

int mouse_pop(mouse_event_t *ev) {
    if (s_head == s_tail) return 0;
    *ev = s_q[s_tail];
    s_tail = (s_tail + 1) % QSIZE;
    return 1;
}

void mouse_feed(uint8_t b) {
    // Первый байт пакета всегда с битом 3; иначе мы рассинхронизировались - ждём валидный.
    if (s_idx == 0 && !(b & 0x08)) return;
    s_pkt[s_idx++] = b;
    if (s_idx < s_pkt_len) return;
    s_idx = 0;

    if (s_pkt[0] & 0xC0) return;                     // переполнение - пакет мусорный

    int dx = s_pkt[1] - ((s_pkt[0] << 4) & 0x100);   // 9-битное значение со знаком
    int dy = s_pkt[2] - ((s_pkt[0] << 3) & 0x100);
    int dz = 0;
    if (s_pkt_len == 4) {
        dz = s_pkt[3] & 0x0F;
        if (dz & 0x08) dz -= 16;
        dz = -dz;                                    // в пакете «вниз» положительно
    }

    s_buttons = s_pkt[0] & 0x07;
    s_x += dx;
    s_y -= dy;                                       // у PS/2 ось Y направлена вверх
    if (s_x < 0) s_x = 0;
    if (s_y < 0) s_y = 0;
    if (s_x >= s_w) s_x = s_w - 1;
    if (s_y >= s_h) s_y = s_h - 1;
    push(dz);
}

int mouse_x(void) { return s_x; }
int mouse_y(void) { return s_y; }
