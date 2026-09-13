
#include "keyboard.h"
#include "terminal.h"
#include "mouse.h"
#include "hotkeys.h"

static const char scancode_to_ascii_lower[] = {
    0, 27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
    '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
    0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`',
    0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0, '*',
    0, ' '
};

static const char scancode_to_ascii_upper[] = {
    0, 27, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '\b',
    '\t', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n',
    0, 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~',
    0, '|', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?', 0, '*',
    0, ' '
};

static const char scancode_to_ascii_lower_rus[] = {
    0, 27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
    '\t', 'й', 'ц', 'у', 'к', 'е', 'н', 'г', 'ш', 'щ', 'з', 'х', 'ъ', '\n',
    0, 'ф', 'ы', 'в', 'а', 'п', 'р', 'о', 'л', 'д', 'ж', 'э', 'ё',
    0, '|', 'я', 'ч', 'с', 'м', 'и', 'т', 'ь', 'б', 'ю', '.', 0, '*',
    0, ' '
};

static const char scancode_to_ascii_upper_rus[] = {
    0, 27, '!', '"', '№', ';', '%', ':', '?', '*', '(', ')', '_', '+', '\b',
    '\t', 'Й', 'Ц', 'У', 'К', 'Е', 'Н', 'Г', 'Ш', 'Щ', 'З', 'Х', 'Ъ', '\n',
    0, 'Ф', 'Ы', 'В', 'А', 'П', 'Р', 'О', 'Л', 'Д', 'Ж', 'Э', 'Ё',
    0, '|', 'Я', 'Ч', 'С', 'М', 'И', 'Т', 'Ь', 'Б', 'Ю', ',', 0, '*',
    0, ' '
};

static uint8_t last_scancode = 0;

char keyboard_get_char(uint8_t scancode)
{
    if (scancode == last_scancode) {
        return 0;
    }

    if (scancode & 0x80) {
        last_scancode = scancode;
        return 0;
    }

    last_scancode = scancode;

    if (scancode < sizeof(scancode_to_ascii_lower)) {
        if (hotkey_is_russian()) {
            if (hotkey_is_shift_pressed()) {
                return scancode_to_ascii_upper_rus[scancode];
            } else {
                return scancode_to_ascii_lower_rus[scancode];
            }
        } else {
            if (hotkey_is_shift_pressed()) {
                return scancode_to_ascii_upper[scancode];
            } else {
                return scancode_to_ascii_lower[scancode];
            }
        }
    }

    return 0;
}

void keyboard_handler(void)
{
    uint8_t scancode = inb(0x60);

    hotkey_handle(scancode);

    char ch = keyboard_get_char(scancode);

    if (ch != 0) {
        putchar(ch);
    }
}

static int keyboard_byte_ready(void)
{
    uint8_t status = inb(0x64);

    if (!(status & 0x01))
        return 0;

    if (status & 0x20)
        return 0;

    return 1;
}

void scan(char *buf, int max_len)
{
    int i = 0;

    while (i < max_len - 1) {
        mouse_poll();

        if (!keyboard_byte_ready()) {
            asm volatile ("nop");
            continue;
        }

        uint8_t scancode = inb(0x60);

        hotkey_handle(scancode);

        char ch = keyboard_get_char(scancode);

        if (ch != 0) {
            if (ch == '\n') {
                putchar('\n');
                break;
            } else if (ch == '\b') {
                if (i > 0) {
                    i--;
                    putchar('\b');
                }
            } else {
                buf[i++] = ch;
                putchar(ch);
            }
        }
    }

    buf[i] = '\0';
}