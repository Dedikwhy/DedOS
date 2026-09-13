#include "mouse.h"
#include "gfx.h"
#include "gui.h"

#define MOUSE_PORT_DATA   0x60
#define MOUSE_PORT_STATUS 0x64
#define MOUSE_PORT_CMD    0x64

static inline uint8_t inb(uint16_t port) {
    uint8_t ret;
    __asm__ volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}
static inline void outb(uint16_t port, uint8_t val) {
    __asm__ volatile ("outb %0, %1" : : "a"(val), "Nd"(port));
}

// type == 0 -> ждём, пока контроллер готов принять команду/данные (буфер ввода пуст)
// type == 1 -> ждём, пока в буфере вывода появятся данные для чтения
static void mouse_wait(int type) {
    uint32_t timeout = 100000;
    if (type == 0) {
        while (timeout--) {
            if ((inb(MOUSE_PORT_STATUS) & 0x02) == 0) return;
        }
    } else {
        while (timeout--) {
            if (inb(MOUSE_PORT_STATUS) & 0x01) return;
        }
    }
}

static void mouse_write(uint8_t data) {
    mouse_wait(0);
    outb(MOUSE_PORT_CMD, 0xD4);
    mouse_wait(0);
    outb(MOUSE_PORT_DATA, data);
}

static uint8_t mouse_read(void) {
    mouse_wait(1);
    return inb(MOUSE_PORT_DATA);
}

static uint8_t packet[3];
static int packet_idx = 0;

static int s_x = 400;
static int s_y = 300;
static int s_left = 0;

void mouse_init(void) {
    // включаем вспомогательное (aux/PS2-мышь) устройство контроллера 8042
    mouse_wait(0);
    outb(MOUSE_PORT_CMD, 0xA8);

    // читаем compaq status byte, включаем IRQ12 бит нам не нужен (прерывания не используем),
    // но бит трансляции и разрешения aux-часов должен быть корректным
    mouse_wait(0);
    outb(MOUSE_PORT_CMD, 0x20);
    uint8_t status = mouse_read();
    status |= 0x02;  // разрешить работу aux-устройства (бит "enable mouse clock")
    status &= ~0x20; // отключить aux-clock disable бит

    mouse_wait(0);
    outb(MOUSE_PORT_CMD, 0x60);
    mouse_wait(0);
    outb(MOUSE_PORT_DATA, status);

    mouse_write(0xF6); // настройки по умолчанию
    mouse_read();       // ACK

    mouse_write(0xF4); // включить поток пакетов
    mouse_read();       // ACK

    if (s_x >= (int)gfx_width())  s_x = (int)gfx_width() / 2;
    if (s_y >= (int)gfx_height()) s_y = (int)gfx_height() / 2;
}

void mouse_poll(void) {
    uint8_t status = inb(MOUSE_PORT_STATUS);
    // бит 0 - есть данные для чтения, бит 5 - данные пришли от aux-устройства (мыши)
    if ((status & 0x21) != 0x21) return;

    uint8_t data = inb(MOUSE_PORT_DATA);
    packet[packet_idx++] = data;

    if (packet_idx < 3) return;
    packet_idx = 0;

    // байт 0 всегда должен иметь установленный бит 3, иначе пакет рассинхронизирован
    if (!(packet[0] & 0x08)) return;
    // биты переполнения - отбрасываем битый пакет
    if (packet[0] & 0xC0) return;

    s_left = packet[0] & 0x01;

    int dx = (int8_t)packet[1];
    int dy = (int8_t)packet[2];

    s_x += dx;
    s_y -= dy; // ось Y у PS/2-мыши инвертирована относительно экрана

    if (s_x < 0) s_x = 0;
    if (s_y < 0) s_y = 0;
    if (s_x >= (int)gfx_width())  s_x = (int)gfx_width() - 1;
    if (s_y >= (int)gfx_height()) s_y = (int)gfx_height() - 1;

    gui_on_mouse_update(s_x, s_y, s_left);
}

int mouse_get_x(void) { return s_x; }
int mouse_get_y(void) { return s_y; }
int mouse_get_left_button(void) { return s_left; }
