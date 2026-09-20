#include "gfx.h"
#include "string.h"
#include "font8x8_basic.h"

#define MAX_W 1024
#define MAX_H 768

static uint32_t  s_back[MAX_W * MAX_H];
static uint32_t *s_fb;
static int s_w, s_h, s_pitch;            // pitch в пикселях

typedef struct { int x0, y0, x1, y1; } clip_t;   // [x0,x1) x [y0,y1)
static clip_t s_clip[8];
static int s_clip_n;

int gfx_init(uint32_t *fb, uint32_t w, uint32_t h, uint32_t pitch_bytes) {
    if (w > MAX_W || h > MAX_H) return 0;
    s_fb = fb;
    s_w = (int)w; s_h = (int)h;
    s_pitch = (int)(pitch_bytes / 4);
    s_clip_n = 1;
    s_clip[0] = (clip_t){ 0, 0, s_w, s_h };
    return 1;
}

int gfx_width(void)  { return s_w; }
int gfx_height(void) { return s_h; }

void gfx_clip_push(int x, int y, int w, int h) {
    clip_t c = s_clip[s_clip_n - 1];
    if (x > c.x0) c.x0 = x;
    if (y > c.y0) c.y0 = y;
    if (x + w < c.x1) c.x1 = x + w;
    if (y + h < c.y1) c.y1 = y + h;
    if (c.x1 < c.x0) c.x1 = c.x0;
    if (c.y1 < c.y0) c.y1 = c.y0;
    if (s_clip_n < 8) s_clip[s_clip_n++] = c;
}

void gfx_clip_pop(void) {
    if (s_clip_n > 1) s_clip_n--;
}

int gfx_visible(int x, int y, int w, int h) {
    const clip_t *c = &s_clip[s_clip_n - 1];
    return x < c->x1 && x + w > c->x0 && y < c->y1 && y + h > c->y0;
}

void gfx_put_pixel(int x, int y, uint32_t col) {
    const clip_t *c = &s_clip[s_clip_n - 1];
    if (x < c->x0 || x >= c->x1 || y < c->y0 || y >= c->y1) return;
    s_back[y * MAX_W + x] = col;
}

static inline void fill_span(uint32_t *p, int n, uint32_t col) {
    __asm__ volatile ("rep stosl" : "+D"(p), "+c"(n) : "a"(col) : "memory");
}

void gfx_fill_rect(int x, int y, int w, int h, uint32_t col) {
    const clip_t *c = &s_clip[s_clip_n - 1];
    int x0 = x < c->x0 ? c->x0 : x;
    int y0 = y < c->y0 ? c->y0 : y;
    int x1 = x + w > c->x1 ? c->x1 : x + w;
    int y1 = y + h > c->y1 ? c->y1 : y + h;
    if (x0 >= x1 || y0 >= y1) return;
    for (int yy = y0; yy < y1; yy++) fill_span(s_back + yy * MAX_W + x0, x1 - x0, col);
}

void gfx_fill_dither(int x, int y, int w, int h, uint32_t c1, uint32_t c2) {
    const clip_t *c = &s_clip[s_clip_n - 1];
    int x0 = x < c->x0 ? c->x0 : x;
    int y0 = y < c->y0 ? c->y0 : y;
    int x1 = x + w > c->x1 ? c->x1 : x + w;
    int y1 = y + h > c->y1 ? c->y1 : y + h;
    for (int yy = y0; yy < y1; yy++) {
        uint32_t *row = s_back + yy * MAX_W;
        for (int xx = x0; xx < x1; xx++) row[xx] = ((xx ^ yy) & 1) ? c2 : c1;
    }
}

void gfx_hline(int x, int y, int w, uint32_t c) { gfx_fill_rect(x, y, w, 1, c); }
void gfx_vline(int x, int y, int h, uint32_t c) { gfx_fill_rect(x, y, 1, h, c); }

void gfx_rect(int x, int y, int w, int h, uint32_t c) {
    if (w <= 0 || h <= 0) return;
    gfx_hline(x, y, w, c);
    gfx_hline(x, y + h - 1, w, c);
    gfx_vline(x, y, h, c);
    gfx_vline(x + w - 1, y, h, c);
}

// ---------- текст ----------

void gfx_char(int x, int y, char ch, uint32_t col, int scale) {
    unsigned char uc = (unsigned char)ch;
    if (uc > 126) uc = '?';
    if (uc < 32) return;
    if (scale < 1) scale = 1;
    if (!gfx_visible(x, y, 8 * scale, 8 * scale)) return;

    const unsigned char *g = font8x8_basic[uc];
    for (int r = 0; r < 8; r++) {
        unsigned char bits = g[r];
        if (!bits) continue;
        for (int b = 0; b < 8; b++) {
            if (!(bits & (1 << b))) continue;
            if (scale == 1) gfx_put_pixel(x + b, y + r, col);
            else gfx_fill_rect(x + b * scale, y + r * scale, scale, scale, col);
        }
    }
}

void gfx_text_scaled(int x, int y, const char *s, uint32_t col, int scale) {
    if (scale < 1) scale = 1;
    for (; *s; s++, x += 8 * scale) gfx_char(x, y, *s, col, scale);
}

void gfx_text_fit(int x, int y, const char *s, uint32_t col, int max_w) {
    int n = max_w / 8;
    for (int i = 0; s[i] && i < n; i++) gfx_char(x + i * 8, y, s[i], col, 1);
}

int gfx_text_width(const char *s) { return (int)strlen(s) * 8; }

// ---------- курсор мыши ----------

#define CUR_W 12
#define CUR_H 17
static const char *const CURSOR[CUR_H] = {
    "X           ",
    "XX          ",
    "XOX         ",
    "XOOX        ",
    "XOOOX       ",
    "XOOOOX      ",
    "XOOOOOX     ",
    "XOOOOOOX    ",
    "XOOOOOOOX   ",
    "XOOOOOOOOX  ",
    "XOOOOOXXXXX ",
    "XOOXOOX     ",
    "XOX XOOX    ",
    "XX  XOOX    ",
    "X    XOOX   ",
    "     XOOX   ",
    "      XX    ",
};

static int s_cur_x = -100, s_cur_y = -100, s_cur_shown;

static void blit(int x, int y, int w, int h) {
    int x0 = x < 0 ? 0 : x, y0 = y < 0 ? 0 : y;
    int x1 = x + w > s_w ? s_w : x + w;
    int y1 = y + h > s_h ? s_h : y + h;
    if (x0 >= x1 || y0 >= y1) return;
    for (int yy = y0; yy < y1; yy++)
        memcpy(s_fb + yy * s_pitch + x0, s_back + yy * MAX_W + x0, (size_t)(x1 - x0) * 4);
}

void gfx_present(int dx, int dy, int dw, int dh, int cx, int cy) {
    // курсор временно рисуем в back buffer, чтобы на экране не было кадра без него
    uint32_t saved[CUR_W * CUR_H];
    for (int r = 0; r < CUR_H; r++)
        for (int c = 0; c < CUR_W; c++) {
            int px = cx + c, py = cy + r;
            int inside = px >= 0 && py >= 0 && px < s_w && py < s_h;
            saved[r * CUR_W + c] = inside ? s_back[py * MAX_W + px] : 0;
            char ch = CURSOR[r][c];
            if (inside && ch != ' ') s_back[py * MAX_W + px] = (ch == 'X') ? 0x0F1315 : 0xFFFFFF;
        }

    if (dw > 0) blit(dx, dy, dw, dh);
    if (s_cur_shown && (s_cur_x != cx || s_cur_y != cy)) blit(s_cur_x, s_cur_y, CUR_W, CUR_H);
    blit(cx, cy, CUR_W, CUR_H);

    for (int r = 0; r < CUR_H; r++)
        for (int c = 0; c < CUR_W; c++) {
            int px = cx + c, py = cy + r;
            if (px >= 0 && py >= 0 && px < s_w && py < s_h) s_back[py * MAX_W + px] = saved[r * CUR_W + c];
        }

    s_cur_x = cx; s_cur_y = cy; s_cur_shown = 1;
}
