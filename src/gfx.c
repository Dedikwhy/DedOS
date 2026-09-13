#include "gfx.h"
#include "font8x8_basic.h"

static uint32_t *s_fb = 0;
static uint32_t s_width = 0;
static uint32_t s_height = 0;
static uint32_t s_pitch_px = 0; // пикселей на строку (pitch в байтах / 4)

void gfx_set_framebuffer(uint32_t *fb, uint32_t width, uint32_t height, uint32_t pitch_bytes) {
    s_fb = fb;
    s_width = width;
    s_height = height;
    s_pitch_px = pitch_bytes / 4;
}

uint32_t gfx_width(void) { return s_width; }
uint32_t gfx_height(void) { return s_height; }

void gfx_put_pixel(int x, int y, uint32_t color) {
    if (!s_fb) return;
    if (x < 0 || y < 0 || (uint32_t)x >= s_width || (uint32_t)y >= s_height) return;
    s_fb[(uint32_t)y * s_pitch_px + (uint32_t)x] = color;
}

uint32_t gfx_get_pixel(int x, int y) {
    if (!s_fb) return 0;
    if (x < 0 || y < 0 || (uint32_t)x >= s_width || (uint32_t)y >= s_height) return 0;
    return s_fb[(uint32_t)y * s_pitch_px + (uint32_t)x];
}

void gfx_fill_rect(int x, int y, int w, int h, uint32_t color) {
    if (!s_fb || w <= 0 || h <= 0) return;

    int x0 = x < 0 ? 0 : x;
    int y0 = y < 0 ? 0 : y;
    int x1 = x + w;
    int y1 = y + h;
    if (x1 > (int)s_width)  x1 = (int)s_width;
    if (y1 > (int)s_height) y1 = (int)s_height;

    for (int yy = y0; yy < y1; yy++) {
        uint32_t *row = s_fb + (uint32_t)yy * s_pitch_px;
        for (int xx = x0; xx < x1; xx++) {
            row[xx] = color;
        }
    }
}

void gfx_draw_hline(int x, int y, int w, uint32_t color) { gfx_fill_rect(x, y, w, 1, color); }
void gfx_draw_vline(int x, int y, int h, uint32_t color) { gfx_fill_rect(x, y, 1, h, color); }

void gfx_draw_rect(int x, int y, int w, int h, uint32_t color) {
    gfx_draw_hline(x, y, w, color);
    gfx_draw_hline(x, y + h - 1, w, color);
    gfx_draw_vline(x, y, h, color);
    gfx_draw_vline(x + w - 1, y, h, color);
}

void gfx_draw_char(int x, int y, char c, uint32_t fg, uint32_t bg, int scale) {
    unsigned char uc = (unsigned char)c;
    if (uc > 127) uc = '?';
    if (scale < 1) scale = 1;

    const unsigned char *glyph = (const unsigned char *)font8x8_basic[uc];

    for (int row = 0; row < 8; row++) {
        unsigned char bits = (unsigned char)glyph[row];
        for (int col = 0; col < 8; col++) {
            uint32_t color = (bits & (1 << col)) ? fg : bg;
            gfx_fill_rect(x + col * scale, y + row * scale, scale, scale, color);
        }
    }
}

void gfx_draw_string(int x, int y, const char *s, uint32_t fg, uint32_t bg, int scale) {
    int cx = x;
    for (int i = 0; s[i] != '\0'; i++) {
        gfx_draw_char(cx, y, s[i], fg, bg, scale);
        cx += 8 * scale;
    }
}

void gfx_blit_up(int x, int y, int w, int h, int dy) {
    if (!s_fb || dy <= 0 || w <= 0 || h <= 0) return;

    for (int row = y; row < y + h - dy; row++) {
        uint32_t *dst = s_fb + (uint32_t)row * s_pitch_px + (uint32_t)x;
        uint32_t *src = s_fb + (uint32_t)(row + dy) * s_pitch_px + (uint32_t)x;
        for (int col = 0; col < w; col++) {
            dst[col] = src[col];
        }
    }
}
