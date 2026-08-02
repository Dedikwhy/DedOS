#include "vga.h"
#include "stdint.h"

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_MEMORY ((volatile unsigned short*) 0xB8000)

static int terminal_row = 0;
static int terminal_column = 0;
static unsigned char terminal_color = (VGA_COLOR_BLACK << 4) | VGA_COLOR_LIGHT_GREEN;

unsigned char vga_entry_color(enum vga_color fg, enum vga_color bg) {
    return fg | (bg << 4);
}

static inline unsigned short vga_entry(unsigned char uc, unsigned char color) {
    return (unsigned short) uc | ((unsigned short) color << 8);
}

void clear(void) {
    for (int y = 0; y < VGA_HEIGHT; y++) {
        for (int x = 0; x < VGA_WIDTH; x++) {
            VGA_MEMORY[y * VGA_WIDTH + x] = vga_entry(' ', terminal_color);
        }
    }
    terminal_row = 0;
    terminal_column = 0;
}

void setcolor(unsigned char color) {
    terminal_color = color;
}

static void scroll(void) {
    if (terminal_row >= VGA_HEIGHT) {
        for (int y = 0; y < VGA_HEIGHT - 1; y++) {
            for (int x = 0; x < VGA_WIDTH; x++) {
                VGA_MEMORY[y * VGA_WIDTH + x] = VGA_MEMORY[(y + 1) * VGA_WIDTH + x];
            }
        }
        for (int x = 0; x < VGA_WIDTH; x++) {
            VGA_MEMORY[(VGA_HEIGHT - 1) * VGA_WIDTH + x] = vga_entry(' ', terminal_color);
        }
        terminal_row = VGA_HEIGHT - 1;
    }
}

void putchar(char c) {
    if (c == '\n') {
        terminal_column = 0;
        terminal_row++;
    } else if (c == '\r') {
        terminal_column = 0;
    } else if (c == '\b') {
        if (terminal_column > 0) {
            terminal_column--;
            VGA_MEMORY[terminal_row * VGA_WIDTH + terminal_column] = vga_entry(' ', terminal_color);
        }
    } else if (c == '\t') {
        terminal_column = (terminal_column + 4) & ~3;
    } else {
        VGA_MEMORY[terminal_row * VGA_WIDTH + terminal_column] = vga_entry((unsigned char)c, terminal_color);
        terminal_column++;
    }

    if (terminal_column >= VGA_WIDTH) {
        terminal_column = 0;
        terminal_row++;
    }

    scroll();
}

void write(const char* data) {
    for (int i = 0; data[i] != '\0'; i++) {
        putchar(data[i]);
    }
}

static void print_dec(int num) {
    if (num == 0) {
        putchar('0');
        return;
    }
    if (num < 0) {
        putchar('-');
        num = -num;
    }
    char buf[32];
    int i = 0;
    while (num > 0) {
        buf[i++] = '0' + (num % 10);
        num /= 10;
    }
    while (i > 0) {
        putchar(buf[--i]);
    }
}

static void print_hex(unsigned int num) {
    write("0x");
    if (num == 0) {
        putchar('0');
        return;
    }
    char buf[32];
    char hex_digits[] = "0123456789ABCDEF";
    int i = 0;
    while (num > 0) {
        buf[i++] = hex_digits[num % 16];
        num /= 16;
    }
    while (i > 0) {
        putchar(buf[--i]);
    }
}

void print(const char* format, ...) {
    __builtin_va_list args;
    __builtin_va_start(args, format);

    for (int i = 0; format[i] != '\0'; i++) {
        if (format[i] == '%') {
            i++;
            switch (format[i]) {
                case 's': {
                    const char* arg = __builtin_va_arg(args, const char*);
                    write(arg ? arg : "(null)");
                    break;
                }
                case 'c': {
                    char arg = (char)__builtin_va_arg(args, int);
                    putchar(arg);
                    break;
                }
                case 'd': {
                    int arg = __builtin_va_arg(args, int);
                    print_dec(arg);
                    break;
                }
                case 'x': {
                    unsigned int arg = __builtin_va_arg(args, unsigned int);
                    print_hex(arg);
                    break;
                }
                case '%': {
                    putchar('%');
                    break;
                }
                default: {
                    putchar('%');
                    putchar(format[i]);
                    break;
                }
            }
        } else {
            putchar(format[i]);
        }
    }

    __builtin_va_end(args);
}

static inline void outb(uint16_t port, uint8_t val) {
    __asm__ volatile ("outb %0, %1" : : "a"(val), "Nd"(port));
}

void disable_cursor(void) {
    outb(0x3D4, 0x0A);
    outb(0x3D5, 0x20);
}