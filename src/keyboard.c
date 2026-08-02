#include "keyboard.h"
#include "terminal.h" 

static const char scancode_to_ascii_lower[] = {
    0,  27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
  '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
    0,  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`',
    0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/',   0, '*',
    0,  ' '
};

static const char scancode_to_ascii_upper[] = {
    0,  27, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '\b',
  '\t', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n',
    0,  'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~',
    0,  '|', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?',   0, '*',
    0,  ' '
};

static int shift_pressed = 0;
static uint8_t last_scancode = 0;

char keyboard_get_char(uint8_t scancode) {
    // 1. Проверяем нажатие и отпускание Shift
    if (scancode == 0x2A || scancode == 0x36) {
        shift_pressed = 1;
        last_scancode = scancode;
        return 0;
    }
    if (scancode == 0xAA || scancode == 0xB6) {
        shift_pressed = 0;
        last_scancode = scancode;
        return 0;
    }

    if (scancode == last_scancode) {
        return 0;
    }

    if (scancode & 0x80) {
        last_scancode = scancode;
        return 0;
    }

    last_scancode = scancode;

    // 5. Преобразуем в ASCII
    if (scancode < sizeof(scancode_to_ascii_lower)) {
        if (shift_pressed) {
            return scancode_to_ascii_upper[scancode];
        } else {
            return scancode_to_ascii_lower[scancode];
        }
    }

    return 0;
}

void keyboard_handler(void) {
    uint8_t scancode = inb(0x60);
    char ch = keyboard_get_char(scancode);

    if (ch != 0) {
        putchar(ch);
    }
}

void scan(char *buf, int max_len) {
    int i = 0;
    while (i < max_len - 1) {
        uint8_t scancode = inb(0x60);
        char ch = keyboard_get_char(scancode);

        if (ch != 0) {
            if (ch == '\n') {
                putchar('\n');
                break;
            } 
            else if (ch == '\b') {
                if (i > 0) {
                    i--;
                    putchar('\b');
                }
            } 
            else {
                buf[i++] = ch;
                putchar(ch);
            }
        }
        asm volatile ("nop");
    }
    buf[i] = '\0';
}