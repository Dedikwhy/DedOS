#ifndef KEYBOARD_H
#define KEYBOARD_H

#include <stdint.h>

// Обычные символы приходят как ASCII (с учётом Shift/Caps). Со Ctrl буква
// приходит строчной + MOD_CTRL. Служебные клавиши - коды >= 0x100.
enum {
    KEY_UP = 0x100, KEY_DOWN, KEY_LEFT, KEY_RIGHT,
    KEY_HOME, KEY_END, KEY_PGUP, KEY_PGDN, KEY_INSERT, KEY_DELETE,
    KEY_F1 = 0x110, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6,
    KEY_F7, KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_F12,
    KEY_SUPER = 0x120,
};

#define MOD_SHIFT 1
#define MOD_CTRL  2
#define MOD_ALT   4

typedef struct {
    uint16_t key;
    uint8_t  mods;
} key_event_t;

void kbd_init(void);
void kbd_feed(uint8_t scancode);        // байт из порта 0x60 (scancode set 1)
int  kbd_pop(key_event_t *ev);          // 1, если событие есть

#endif
