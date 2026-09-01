#ifndef VBE_H
#define VBE_H

#include <stdint.h>

typedef struct {
    uint32_t *fb;      // линейный адрес framebuffer (uint32_t = 1 пиксель, 0x00RRGGBB)
    uint32_t width;
    uint32_t height;
    uint32_t pitch;     // байт на строку
} vbe_info_t;

// Пытается найти VGA-совместимое PCI устройство (QEMU std/Bochs VBE),
// включить линейный framebuffer нужного разрешения.
// Возвращает 1 при успехе, 0 при неудаче (нет такого устройства/эмуляции).
int vbe_init(uint32_t width, uint32_t height, uint32_t bpp);

const vbe_info_t *vbe_get_info(void);

#endif
