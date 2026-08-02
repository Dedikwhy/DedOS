#ifndef KEYBOARD_H
#define KEYBOARD_H

#include <stdint.h>

static inline uint8_t inb(uint16_t port) {
    uint8_t ret;
    asm volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

char keyboard_get_char(uint8_t scancode);
void keyboard_handler(void);
void scan(char *buf, int max_len);

#endif