#ifndef GFX_H
#define GFX_H

#include <stdint.h>

// Подключает framebuffer (из vbe.c) к графической библиотеке.
// pitch_bytes - байт на строку (как в vbe_info_t.pitch).
void gfx_set_framebuffer(uint32_t *fb, uint32_t width, uint32_t height, uint32_t pitch_bytes);

uint32_t gfx_width(void);
uint32_t gfx_height(void);

void gfx_put_pixel(int x, int y, uint32_t color);
uint32_t gfx_get_pixel(int x, int y);
void gfx_fill_rect(int x, int y, int w, int h, uint32_t color);
void gfx_draw_rect(int x, int y, int w, int h, uint32_t color);
void gfx_draw_hline(int x, int y, int w, uint32_t color);
void gfx_draw_vline(int x, int y, int h, uint32_t color);

// scale = 1 -> символ 8x8 пикселей, scale = 2 -> 16x16 и т.д.
void gfx_draw_char(int x, int y, char c, uint32_t fg, uint32_t bg, int scale);
void gfx_draw_string(int x, int y, const char *s, uint32_t fg, uint32_t bg, int scale);

// Сдвигает прямоугольную область на dy пикселей вверх (для скролла окна).
void gfx_blit_up(int x, int y, int w, int h, int dy);

#endif
