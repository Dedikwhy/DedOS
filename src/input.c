#include "input.h"
#include "keyboard.h"
#include "mouse.h"
#include "io.h"

void input_poll(void) {
    for (int i = 0; i < 64; i++) {
        uint8_t st = inb(0x64);
        if (!(st & 0x01)) return;
        uint8_t b = inb(0x60);
        if (st & 0x20) mouse_feed(b);
        else           kbd_feed(b);
    }
}
