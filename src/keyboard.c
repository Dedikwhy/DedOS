#include "keyboard.h"

extern void putchar(char c);

static const char scancode_ascii[128] = {
    0,  27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
  '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
    0,  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`',
    0,  '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0,
   '*',   0, ' '
};

char keyboard_get_char(void) {
    while (1) {
        if (inb(0x64) & 0x01) {
            uint8_t scancode = inb(0x60);
            if (!(scancode & 0x80)) {
                if (scancode < 128) {
                    char c = scancode_ascii[scancode];
                    if (c != 0) return c;
                }
            }
        }
    }
}

// Переименовали в scan!
void scan(char *buf, int max_len) {
    int i = 0;

    while (i < max_len - 1) {
        char c = keyboard_get_char();

        if (c == '\n') {
            putchar('\n');
            break;
        }

        if (c == '\b') {
            if (i > 0) {
                i--;
                putchar('\b');
                putchar(' ');
                putchar('\b');
            }
            continue;
        }

        buf[i++] = c;
        putchar(c);
    }

    buf[i] = '\0';
}