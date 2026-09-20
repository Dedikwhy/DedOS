#ifndef GFX_H
#define GFX_H

#include <stdint.h>

// Всё рисуется в back buffer (в ОЗУ). На экран попадает только gfx_present():
// копирует изменённый прямоугольник в видеопамять и рисует курсор мыши.

int  gfx_init(uint32_t *fb, uint32_t width, uint32_t height, uint32_t pitch_bytes);
int  gfx_width(void);
int  gfx_height(void);

// --- отсечение: все примитивы ограничены текущим clip ---
void gfx_clip_push(int x, int y, int w, int h);   // пересекается с текущим
void gfx_clip_pop(void);
int  gfx_visible(int x, int y, int w, int h);     // пересекается ли прямоугольник с clip

// --- примитивы ---
void gfx_put_pixel(int x, int y, uint32_t c);
void gfx_fill_rect(int x, int y, int w, int h, uint32_t c);
void gfx_fill_dither(int x, int y, int w, int h, uint32_t c1, uint32_t c2);  // шахматка 1x1
void gfx_hline(int x, int y, int w, uint32_t c);
void gfx_vline(int x, int y, int h, uint32_t c);
void gfx_rect(int x, int y, int w, int h, uint32_t c);                       // контур 1px

// --- текст (шрифт 8x8, ASCII) ---
void gfx_char(int x, int y, char ch, uint32_t c, int scale);
void gfx_text_scaled(int x, int y, const char *s, uint32_t c, int scale);
void gfx_text_fit(int x, int y, const char *s, uint32_t c, int max_w);       // обрезает по ширине
int  gfx_text_width(const char *s);
static inline void gfx_text(int x, int y, const char *s, uint32_t c) { gfx_text_scaled(x, y, s, c, 1); }

// --- вывод на экран ---
// (dw > 0) - скопировать прямоугольник сцены; курсор рисуется в (cx, cy).
void gfx_present(int dx, int dy, int dw, int dh, int cx, int cy);

#endif
