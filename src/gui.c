#include "gui.h"
#include "gfx.h"
#include "theme.h"
#include "icons.h"
#include "apps.h"
#include "input.h"
#include "mouse.h"
#include "timer.h"
#include "string.h"
#include "io.h"
#include "fs.h"

#define MAX_WINDOWS 12

static window_t  s_wins[MAX_WINDOWS];
static window_t *s_order[MAX_WINDOWS];     // z-порядок: [0] - самое заднее окно
static int       s_norder;

static int s_w, s_h;                        // размер экрана

// ---------- грязный прямоугольник ----------

static int s_dirty, s_dx0, s_dy0, s_dx1, s_dy1;

void gui_invalidate(int x, int y, int w, int h) {
    int x1 = x + w, y1 = y + h;
    if (x < 0) x = 0;
    if (y < 0) y = 0;
    if (x1 > s_w) x1 = s_w;
    if (y1 > s_h) y1 = s_h;
    if (x >= x1 || y >= y1) return;
    if (!s_dirty) { s_dx0 = x; s_dy0 = y; s_dx1 = x1; s_dy1 = y1; s_dirty = 1; return; }
    if (x < s_dx0) s_dx0 = x;
    if (y < s_dy0) s_dy0 = y;
    if (x1 > s_dx1) s_dx1 = x1;
    if (y1 > s_dy1) s_dy1 = y1;
}

void gui_invalidate_window(window_t *w) {
    gui_invalidate_client(w, 0, 0, w->cw, w->ch);
}

void gui_invalidate_client(window_t *w, int rx, int ry, int rw, int rh) {
    gui_invalidate(gui_client_x(w) + rx, gui_client_y(w) + ry, rw, rh);
}

// ---------- геометрия ----------

#define ICON_X     20
#define ICON_Y0    20
#define ICON_STEP  90
#define ICON_CELL_W 76
#define ICON_CELL_H 76

static int panel_y(void) { return s_h - PANEL_H; }

static void launcher_rect(int *x, int *y, int *w, int *h) { *x = 4; *y = panel_y() + 3; *w = 76; *h = PANEL_H - 6; }
static void clock_rect(int *x, int *y, int *w, int *h)    { *x = s_w - 76; *y = panel_y() + 1; *w = 76; *h = PANEL_H - 1; }

static int collect_tasks(window_t **out) {
    int n = 0;
    for (int i = 0; i < MAX_WINDOWS; i++) if (s_wins[i].used) out[n++] = &s_wins[i];
    return n;
}

static void task_rect(int i, int n, int *x, int *y, int *w, int *h) {
    int x0 = 88, avail = s_w - 76 - 8 - x0;
    int bw = n > 0 ? avail / n - 4 : 160;
    if (bw > 160) bw = 160;
    if (bw < 60) bw = 60;
    *x = x0 + i * (bw + 4); *y = panel_y() + 3; *w = bw; *h = PANEL_H - 6;
}

static void icon_rect(int i, int *x, int *y, int *w, int *h) {
    *x = ICON_X; *y = ICON_Y0 + i * ICON_STEP; *w = ICON_CELL_W; *h = ICON_CELL_H;
}

// ---------- всплывающее меню (лаунчер и ПКМ) ----------

#define MENU_ITEM_H 26
#define MENU_SEP_H  9
#define MENU_PAD    3
#define MAX_MENU    12
#define MK_RESTART_ID  100
#define MK_SHUTDOWN_ID 101

typedef struct { const char *label; int icon; int id; int sep; } menu_item_t;

static menu_item_t s_menu[MAX_MENU];
static int   s_nmenu, s_menu_open, s_menu_sel = -1;
static int   s_menu_x, s_menu_y, s_menu_w;
static void (*s_menu_cb)(void *ctx, int id);
static void *s_menu_ctx;

static void launcher_cb(void *ctx, int id);
static void menu_close(void);
static int menu_is_launcher(void) { return s_menu_open && s_menu_cb == launcher_cb; }

static int menu_height(void) {
    int h = MENU_PAD * 2;
    for (int i = 0; i < s_nmenu; i++) h += s_menu[i].sep ? MENU_SEP_H : MENU_ITEM_H;
    return h;
}

static void menu_frame(int *x, int *y, int *w, int *h) {
    *x = s_menu_x; *y = s_menu_y; *w = s_menu_w; *h = menu_height();
}

static void menu_item_rect(int idx, int *x, int *y, int *w, int *h) {
    int yy = s_menu_y + MENU_PAD;
    for (int i = 0; i < idx; i++) yy += s_menu[i].sep ? MENU_SEP_H : MENU_ITEM_H;
    *x = s_menu_x + 4; *y = yy; *w = s_menu_w - 4 - MENU_PAD; *h = s_menu[idx].sep ? MENU_SEP_H : MENU_ITEM_H;
}

// ---------- цели мыши (hover / нажатие) ----------

enum { T_NONE, T_ICON, T_LAUNCH, T_TASK, T_MENU, T_CLOSE, T_TITLE, T_CLIENT, T_CLOCK };
typedef struct { int kind; int idx; window_t *win; } target_t;

static target_t s_hover, s_press;
static window_t *s_drag, *s_capture, *s_hover_win;
static int s_drag_dx, s_drag_dy;
static int s_left;
static int s_icon_sel = -1;

static int same(target_t a, target_t b) { return a.kind == b.kind && a.idx == b.idx && a.win == b.win; }
static int in_rect(int px, int py, int x, int y, int w, int h) { return px >= x && px < x + w && py >= y && py < y + h; }

static void close_box_rect(const window_t *w, int *x, int *y, int *bw, int *bh) {
    *x = w->x + 7; *y = w->y + 5; *bw = 11; *bh = 11;
}

static window_t *top_window(void) { return s_norder ? s_order[s_norder - 1] : 0; }

static target_t pick(int px, int py) {
    target_t t = { T_NONE, 0, 0 };
    int x, y, w, h;

    if (s_menu_open) {
        menu_frame(&x, &y, &w, &h);
        if (in_rect(px, py, x, y, w, h)) {
            t.kind = T_MENU; t.idx = -1;
            for (int i = 0; i < s_nmenu; i++) {
                menu_item_rect(i, &x, &y, &w, &h);
                if (!s_menu[i].sep && in_rect(px, py, x, y, w, h)) { t.idx = i; break; }
            }
            return t;
        }
    }

    if (py >= panel_y()) {
        launcher_rect(&x, &y, &w, &h);
        if (in_rect(px, py, x, y, w, h)) { t.kind = T_LAUNCH; return t; }
        window_t *tasks[MAX_WINDOWS];
        int n = collect_tasks(tasks);
        for (int i = 0; i < n; i++) {
            task_rect(i, n, &x, &y, &w, &h);
            if (in_rect(px, py, x, y, w, h)) { t.kind = T_TASK; t.idx = i; t.win = tasks[i]; return t; }
        }
        t.kind = T_CLOCK;
        return t;
    }

    for (int i = s_norder - 1; i >= 0; i--) {
        window_t *win = s_order[i];
        if (!in_rect(px, py, win->x, win->y, win->w, win->h)) continue;
        t.win = win;
        close_box_rect(win, &x, &y, &w, &h);
        if (in_rect(px, py, x, y, w, h)) t.kind = T_CLOSE;
        else if (py < win->y + TITLE_H + 1)  t.kind = T_TITLE;
        else                                 t.kind = T_CLIENT;
        return t;
    }

    for (int i = 0; i < APP_COUNT; i++) {
        icon_rect(i, &x, &y, &w, &h);
        if (in_rect(px, py, x, y, w, h)) { t.kind = T_ICON; t.idx = i; return t; }
    }
    return t;
}

static int target_rect(target_t t, int *x, int *y, int *w, int *h) {
    window_t *tasks[MAX_WINDOWS];
    switch (t.kind) {
    case T_ICON:   icon_rect(t.idx, x, y, w, h); return 1;
    case T_LAUNCH: launcher_rect(x, y, w, h); return 1;
    case T_TASK:   task_rect(t.idx, collect_tasks(tasks), x, y, w, h); return 1;
    case T_MENU:   if (t.idx < 0) return 0; menu_item_rect(t.idx, x, y, w, h); return 1;
    case T_CLOSE:  close_box_rect(t.win, x, y, w, h); return 1;
    }
    return 0;
}

static void invalidate_target(target_t t) {
    int x, y, w, h;
    if (target_rect(t, &x, &y, &w, &h)) gui_invalidate(x - 1, y - 1, w + 2, h + 2);
}

// ---------- окна ----------

static void invalidate_outer(const window_t *w) { gui_invalidate(w->x, w->y, w->w, w->h); }

static void hud_rect(int *x, int *y, int *w, int *h);

static void invalidate_panel(void) {
    int x, y, w, h;
    gui_invalidate(0, panel_y(), s_w, PANEL_H);
    hud_rect(&x, &y, &w, &h);
    gui_invalidate(x, y, w, h);                 // HUD показывает список окон
}

window_t *gui_create_window(const app_t *app, const char *title, int cw, int ch, void *priv) {
    window_t *w = 0;
    for (int i = 0; i < MAX_WINDOWS; i++) if (!s_wins[i].used) { w = &s_wins[i]; break; }
    if (!w) return 0;

    memset(w, 0, sizeof(*w));
    w->used = 1;
    w->app = app;
    w->priv = priv;
    w->cw = cw; w->ch = ch;
    w->w = cw + 2;
    w->h = ch + TITLE_H + 2;
    strlcpy(w->title, title, sizeof(w->title));

    static int cascade;
    w->x = 70 + (cascade % 6) * 30 + 60;
    w->y = 20 + (cascade % 6) * 30;
    cascade++;
    if (w->x + w->w > s_w) w->x = s_w - w->w;
    if (w->y + w->h > panel_y()) w->y = panel_y() - w->h;
    if (w->x < 0) w->x = 0;
    if (w->y < 0) w->y = 0;

    if (top_window()) invalidate_outer(top_window());       // прежнее активное окно станет неактивным
    s_order[s_norder++] = w;
    invalidate_outer(w);
    invalidate_panel();
    return w;
}

void gui_focus_window(window_t *w) {
    if (!w || top_window() == w) return;
    window_t *old = top_window();
    int i = 0;
    while (i < s_norder && s_order[i] != w) i++;
    if (i == s_norder) return;
    for (; i + 1 < s_norder; i++) s_order[i] = s_order[i + 1];
    s_order[s_norder - 1] = w;
    invalidate_outer(w);
    if (old) invalidate_outer(old);
    invalidate_panel();
}

int gui_is_focused(const window_t *w) { return top_window() == w; }

void gui_set_title(window_t *w, const char *title) {
    strlcpy(w->title, title, sizeof(w->title));
    gui_invalidate(w->x, w->y, w->w, TITLE_H + 1);
    invalidate_panel();
}

void gui_close_window(window_t *w) {
    if (!w || !w->used) return;
    menu_close();
    if (w->app && w->app->close) w->app->close(w);

    invalidate_outer(w);
    int i = 0;
    while (i < s_norder && s_order[i] != w) i++;
    for (; i + 1 < s_norder; i++) s_order[i] = s_order[i + 1];
    if (s_norder) s_norder--;
    w->used = 0;

    if (s_drag == w) s_drag = 0;
    if (s_capture == w) s_capture = 0;
    if (s_hover_win == w) s_hover_win = 0;
    if (s_press.win == w) s_press.kind = T_NONE;
    if (s_hover.win == w) s_hover.kind = T_NONE;

    if (top_window()) invalidate_outer(top_window());
    invalidate_panel();
}

static void move_window(window_t *w, int nx, int ny) {
    int maxx = s_w - w->w, maxy = panel_y() - w->h;
    if (nx > maxx) nx = maxx;
    if (ny > maxy) ny = maxy;
    if (nx < 0) nx = 0;
    if (ny < 0) ny = 0;
    if (nx == w->x && ny == w->y) return;
    invalidate_outer(w);
    w->x = nx; w->y = ny;
    invalidate_outer(w);
}

// ---------- отрисовка ----------

static char s_clock[8] = "--:--";
static char s_clock_full[10] = "--:--:--";
static rtc_time_t s_rtc;

static void upper_copy(char *dst, const char *src, int n) {
    int i = 0;
    for (; src[i] && i < n - 1; i++) dst[i] = (src[i] >= 'a' && src[i] <= 'z') ? (char)(src[i] - 32) : src[i];
    dst[i] = '\0';
}

// ---- HUD справа на рабочем столе ----

#define HUD_W 284
#define HUD_H 318

static void hud_rect(int *x, int *y, int *w, int *h) { *x = s_w - HUD_W - 12; *y = 12; *w = HUD_W; *h = HUD_H; }

static void hud_header(int x, int y, const char *left, const char *right) {
    gfx_text(x, y, left, COL_ACCENT_DARK);
    gfx_text(x + HUD_W - gfx_text_width(right), y, right, COL_ACCENT_DARK);
    gfx_hline(x, y + 12, HUD_W, COL_PANEL_EDGE);
}

static void hud_stat(int x, int y, const char *label, const char *value) {
    int cw = HUD_W / 4;
    gfx_text(x + (cw - gfx_text_width(label)) / 2, y, label, COL_ACCENT_DARK);
    gfx_text(x + (cw - gfx_text_width(value)) / 2, y + 12, value, COL_TEXT);
}

static void paint_hud(void) {
    int x, y, w, h;
    hud_rect(&x, &y, &w, &h);
    if (!gfx_visible(x, y, w, h)) return;

    static const char *const months[12] = { "JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC" };
    char b[40];

    hud_header(x, y, "PANEL", "SYSTEM");
    gfx_text_scaled(x + (HUD_W - 8 * 32) / 2, y + 24, s_clock_full, COL_TITLE_TEXT, 4);
    gfx_hline(x, y + 66, HUD_W, COL_PANEL_EDGE);

    uint32_t up = timer_ms() / 1000;
    int m = s_rtc.month >= 1 && s_rtc.month <= 12 ? s_rtc.month - 1 : 0;
    window_t *tasks[MAX_WINDOWS];
    int nt = collect_tasks(tasks);
    int cw = HUD_W / 4;
    ksnprintf(b, sizeof(b), "%s %d", months[m], s_rtc.day);
    hud_stat(x, y + 74, "DATE", b);
    ksnprintf(b, sizeof(b), "%d:%02d:%02d", (int)(up / 3600), (int)(up / 60 % 60), (int)(up % 60));
    hud_stat(x + cw, y + 74, "UPTIME", b);
    hud_stat(x + cw * 2, y + 74, "TYPE", "DEDOS");
    ksnprintf(b, sizeof(b), "%d", nt);
    hud_stat(x + cw * 3, y + 74, "WINDOWS", b);
    gfx_hline(x, y + 102, HUD_W, COL_PANEL_EDGE);

    int used, total;
    fs_usage(&used, &total);
    ksnprintf(b, sizeof(b), "%d/%d", used, total);
    hud_header(x, y + 110, "FILESYSTEM", b);
    gfx_rect(x, y + 128, HUD_W, 8, COL_PANEL_EDGE);
    gfx_fill_rect(x + 2, y + 130, (HUD_W - 4) * used / total, 4, COL_ACCENT);

    hud_header(x, y + 148, "WINDOWS", "ID | NAME");
    for (int i = 0; i < nt && i < 6; i++) {
        char t[40];
        upper_copy(t, tasks[i]->title, 30);
        int focus = (tasks[i] == top_window());
        ksnprintf(b, sizeof(b), "%c%d  %s", focus ? '>' : ' ', i + 1, t);
        gfx_text_fit(x, y + 168 + i * 12, b, focus ? COL_TITLE_TEXT : COL_ACCENT_DARK, HUD_W);
    }
    if (nt == 0) gfx_text(x, y + 168, "NO WINDOWS OPEN", COL_ACCENT_DARK);

    hud_header(x, y + 250, "HOTKEYS", "");
    static const char *const keys[4] = { "ALT+F2 TERMINAL   ALT+F3 FILES", "ALT+TAB NEXT   ALT+1..9 FOCUS", "ALT+F4 CLOSE   ALT+C CENTER", "RIGHT CLICK: CONTEXT MENU" };
    for (int i = 0; i < 4; i++) gfx_text(x, y + 270 + i * 12, keys[i], COL_ACCENT_DARK);
}

static void paint_desktop(void) {
    gfx_fill_rect(0, 0, s_w, panel_y(), COL_DESKTOP);
    for (int gy = 8; gy < panel_y(); gy += 16)
        for (int gx = 8; gx < s_w; gx += 16) gfx_put_pixel(gx, gy, COL_DESKTOP_DOT);

    for (int i = 0; i < APP_COUNT; i++) {
        int x, y, w, h;
        icon_rect(i, &x, &y, &w, &h);
        if (!gfx_visible(x, y, w, h)) continue;

        int hover = (s_hover.kind == T_ICON && s_hover.idx == i);
        int sel = (s_icon_sel == i);
        if (hover && !sel) gfx_rect(x, y, w, h, COL_PANEL_EDGE);
        icon_draw(APP_LIST[i].icon, x + (w - 48) / 2, y + 6, 48);

        const char *label = APP_LIST[i].label;
        int tw = gfx_text_width(label);
        int tx = x + (w - tw) / 2, ty = y + 58;
        if (sel) gfx_fill_rect(tx - 4, ty - 2, tw + 8, 12, COL_SELECT);
        gfx_text(tx, ty, label, sel ? COL_SELECT_TEXT : COL_TEXT_LIGHT);
    }
    paint_hud();
}

static void paint_close_box(const window_t *w, int active) {
    int x, y, bw, bh;
    close_box_rect(w, &x, &y, &bw, &bh);
    target_t me = { T_CLOSE, 0, (window_t *)w };
    int hover = same(s_hover, me);
    int pressed = hover && same(s_press, me);

    uint32_t line = active ? COL_ACCENT : COL_ACCENT_DARK;
    uint32_t fill = pressed ? COL_ACCENT_DARK : hover ? COL_ACCENT : COL_WINDOW_ALT;
    uint32_t mark = hover ? COL_INK : line;
    gfx_fill_rect(x, y, bw, bh, fill);
    gfx_rect(x, y, bw, bh, line);
    for (int i = 0; i < 5; i++) {
        gfx_put_pixel(x + 3 + i, y + 3 + i, mark);
        gfx_put_pixel(x + 3 + i, y + 7 - i, mark);
    }
}

static void paint_window(window_t *w) {
    if (!gfx_visible(w->x, w->y, w->w, w->h)) return;
    int active = (w == top_window());
    uint32_t line = active ? COL_ACCENT_DARK : COL_BORDER;

    gfx_rect(w->x, w->y, w->w, w->h, line);
    gfx_fill_rect(w->x + 1, w->y + 1, w->w - 2, TITLE_H - 1, COL_WINDOW_ALT);
    gfx_hline(w->x + 1, w->y + TITLE_H, w->w - 2, line);

    char t[40];
    upper_copy(t, w->title, sizeof(t));
    gfx_text_fit(w->x + 26, w->y + 6, t, active ? COL_TITLE_TEXT : COL_TITLE_TEXT_OFF, w->w - 26 - 8);
    paint_close_box(w, active);

    if (active) {                                           // «уголки» HUD у активного окна
        int x1 = w->x + w->w - 1, y1 = w->y + w->h - 1;
        gfx_hline(w->x, w->y, 10, COL_ACCENT);   gfx_vline(w->x, w->y, 10, COL_ACCENT);
        gfx_hline(x1 - 9, w->y, 10, COL_ACCENT); gfx_vline(x1, w->y, 10, COL_ACCENT);
        gfx_hline(w->x, y1, 10, COL_ACCENT);     gfx_vline(w->x, y1 - 9, 10, COL_ACCENT);
        gfx_hline(x1 - 9, y1, 10, COL_ACCENT);   gfx_vline(x1, y1 - 9, 10, COL_ACCENT);
    }

    int cx = gui_client_x(w), cy = gui_client_y(w);
    gfx_clip_push(cx, cy, w->cw, w->ch);
    gfx_fill_rect(cx, cy, w->cw, w->ch, COL_WINDOW);
    if (w->app && w->app->paint) w->app->paint(w, cx, cy, w->cw, w->ch);
    gfx_clip_pop();
}

static void paint_panel(void) {
    int py = panel_y();
    if (!gfx_visible(0, py, s_w, PANEL_H)) return;
    gfx_fill_rect(0, py, s_w, PANEL_H, COL_PANEL);
    gfx_hline(0, py, s_w, COL_PANEL_EDGE);

    int x, y, w, h;
    launcher_rect(&x, &y, &w, &h);
    target_t tl = { T_LAUNCH, 0, 0 };
    int open = menu_is_launcher();
    int lh = same(s_hover, tl);
    gfx_fill_rect(x, y, w, h, open ? COL_SELECT : lh ? COL_BUTTON_HOVER : COL_PANEL_BUTTON);
    gfx_rect(x, y, w, h, open ? COL_SELECT : COL_ACCENT_DARK);
    uint32_t lt = open ? COL_INK : COL_TITLE_TEXT;
    gfx_text(x + (w - 40) / 2, y + (h - 8) / 2, "DEDOS", lt);
    gfx_text(x + (w - 40) / 2 + 1, y + (h - 8) / 2, "DEDOS", lt);          // «жирный»

    window_t *tasks[MAX_WINDOWS];
    int n = collect_tasks(tasks);
    for (int i = 0; i < n; i++) {
        task_rect(i, n, &x, &y, &w, &h);
        target_t tt = { T_TASK, i, tasks[i] };
        int active = (tasks[i] == top_window());
        int hover = same(s_hover, tt);
        int pressed = hover && same(s_press, tt);
        uint32_t bg = active ? COL_SELECT : (pressed || hover) ? COL_PANEL_HOVER : COL_PANEL_BUTTON;
        gfx_fill_rect(x, y, w, h, bg);
        if (!active) gfx_rect(x, y, w, h, COL_PANEL_EDGE);
        char t[40];
        upper_copy(t, tasks[i]->title, sizeof(t));
        gfx_text_fit(x + 8, y + (h - 8) / 2, t, active ? COL_INK : COL_PANEL_DIM, w - 12);
    }

    clock_rect(&x, &y, &w, &h);
    gfx_vline(x, y + 3, h - 6, COL_PANEL_EDGE);
    gfx_text(x + (w - gfx_text_width(s_clock)) / 2, y + (h - 8) / 2, s_clock, COL_PANEL_TEXT);
}

static void paint_menu(void) {
    int x, y, w, h;
    menu_frame(&x, &y, &w, &h);
    if (!gfx_visible(x, y, w, h)) return;

    gfx_fill_rect(x, y, w, h, COL_WINDOW_ALT);
    gfx_rect(x, y, w, h, COL_ACCENT_DARK);
    gfx_fill_rect(x + 1, y + 1, 2, h - 2, COL_ACCENT_DARK);      // полоса слева

    for (int i = 0; i < s_nmenu; i++) {
        int ix, iy, iw, ih;
        menu_item_rect(i, &ix, &iy, &iw, &ih);
        if (s_menu[i].sep) {
            gfx_hline(ix + 4, iy + ih / 2, iw - 8, COL_PANEL_EDGE);
            continue;
        }
        int sel = (s_menu_sel == i);
        if (sel) gfx_fill_rect(ix, iy, iw, ih, COL_SELECT);
        int tx = ix + 10;
        if (s_menu[i].icon >= 0) {
            icon_draw(s_menu[i].icon, ix + 6, iy + (ih - 16) / 2, 16);
            tx = ix + 32;
        }
        gfx_text(tx, iy + (ih - 8) / 2, s_menu[i].label, sel ? COL_SELECT_TEXT : COL_TEXT);
    }
}

static void paint_scene(void) {
    paint_desktop();
    for (int i = 0; i < s_norder; i++) paint_window(s_order[i]);
    paint_panel();
    if (s_menu_open) paint_menu();
}

// ---------- питание ----------

static void halt_forever(void) {
    for (;;) __asm__ volatile ("cli; hlt");
}

static void power_screen(const char *msg) {
    gfx_clip_push(0, 0, s_w, s_h);
    gfx_fill_rect(0, 0, s_w, s_h, 0x000000);
    gfx_text(s_w / 2 - gfx_text_width(msg) / 2, s_h / 2 - 4, msg, COL_ACCENT);
    gfx_clip_pop();
    gfx_present(0, 0, s_w, s_h, -100, -100);
}

static void power_off(void) {
    power_screen("It is now safe to turn off your computer.");
    outw(0x604, 0x2000);       // QEMU (ACPI)
    outw(0xB004, 0x2000);      // старый QEMU / Bochs
    outw(0x4004, 0x3400);      // VirtualBox
    halt_forever();
}

static void reboot(void) {
    power_screen("Restarting...");
    for (int i = 0; i < 100000 && (inb(0x64) & 0x02); i++) {}
    outb(0x64, 0xFE);          // импульс reset через контроллер клавиатуры
    halt_forever();
}

// ---------- меню: логика ----------

static void menu_close(void) {
    if (!s_menu_open) return;
    int x, y, w, h;
    menu_frame(&x, &y, &w, &h);
    gui_invalidate(x, y, w, h);
    invalidate_target((target_t){ T_LAUNCH, 0, 0 });
    s_menu_open = 0;
    s_menu_sel = -1;
}

static void menu_setup(const gui_menu_item_t *items, int n, void (*cb)(void *, int), void *ctx) {
    if (n > MAX_MENU) n = MAX_MENU;
    int maxw = 0, icons = 0;
    for (int i = 0; i < n; i++) {
        s_menu[i].label = items[i].label;
        s_menu[i].icon = items[i].icon;
        s_menu[i].id = items[i].id;
        s_menu[i].sep = (items[i].label == 0);
        if (items[i].label && (int)strlen(items[i].label) * 8 > maxw) maxw = (int)strlen(items[i].label) * 8;
        if (items[i].icon >= 0) icons = 1;
    }
    s_nmenu = n;
    s_menu_w = maxw + (icons ? 44 : 28) + 8;
    if (s_menu_w < 140) s_menu_w = 140;
    s_menu_cb = cb;
    s_menu_ctx = ctx;
}

static void menu_show(int x, int y, int sel) {
    s_menu_x = x; s_menu_y = y;
    s_menu_open = 1;
    s_menu_sel = sel;
    int fx, fy, fw, fh;
    menu_frame(&fx, &fy, &fw, &fh);
    gui_invalidate(fx, fy, fw, fh);
    invalidate_target((target_t){ T_LAUNCH, 0, 0 });
}

void gui_popup(int x, int y, const gui_menu_item_t *items, int n, void (*cb)(void *, int), void *ctx) {
    menu_close();
    menu_setup(items, n, cb, ctx);
    int h = menu_height();
    if (x + s_menu_w > s_w) x = s_w - s_menu_w;
    if (y + h > panel_y()) y -= h;                 // не влезает вниз - раскрываем вверх
    if (x < 0) x = 0;
    if (y < 0) y = 0;
    menu_show(x, y, -1);
}

static void launcher_open(int by_key) {
    gui_menu_item_t it[MAX_MENU];
    int n = 0;
    for (int i = 0; i < APP_COUNT && n < MAX_MENU - 3; i++)
        it[n++] = (gui_menu_item_t){ APP_LIST[i].label, APP_LIST[i].icon, i };
    it[n++] = (gui_menu_item_t){ 0, -1, 0 };
    it[n++] = (gui_menu_item_t){ "Restart",   ICON_RESTART, MK_RESTART_ID };
    it[n++] = (gui_menu_item_t){ "Shut Down", ICON_POWER,   MK_SHUTDOWN_ID };
    menu_close();
    menu_setup(it, n, launcher_cb, 0);
    menu_show(4, panel_y() - menu_height() - 2, by_key ? 0 : -1);
}

static void menu_toggle(int by_key) {
    if (menu_is_launcher()) menu_close();
    else launcher_open(by_key);
}

static void menu_activate(int idx) {
    if (idx < 0 || idx >= s_nmenu || s_menu[idx].sep) return;
    int id = s_menu[idx].id;
    void (*cb)(void *, int) = s_menu_cb;
    void *ctx = s_menu_ctx;
    menu_close();
    if (cb) cb(ctx, id);
}

static void menu_move(int dir) {
    int i = s_menu_sel;
    for (int n = 0; n < s_nmenu; n++) {
        i = (i + dir + s_nmenu) % s_nmenu;
        if (!s_menu[i].sep) break;
    }
    if (i != s_menu_sel) {
        int x, y, w, h;
        menu_frame(&x, &y, &w, &h);
        gui_invalidate(x, y, w, h);
        s_menu_sel = i;
    }
}

static void launcher_cb(void *ctx, int id) {
    (void)ctx;
    if (id == MK_RESTART_ID) reboot();
    else if (id == MK_SHUTDOWN_ID) power_off();
    else if (id >= 0 && id < APP_COUNT) APP_LIST[id].open();
}

// ---------- события ----------

static void send_mouse(window_t *w, int type, int x, int y, int buttons, int dz, int dbl) {
    if (!w || !w->app || !w->app->mouse) return;
    wmouse_t m;
    m.type = type;
    m.x = x - gui_client_x(w);
    m.y = y - gui_client_y(w);
    m.buttons = buttons; m.dz = dz; m.dbl = dbl;
    w->app->mouse(w, &m);
}

static void update_hover(int x, int y) {
    target_t t = pick(x, y);
    if (!same(t, s_hover)) {
        invalidate_target(s_hover);
        invalidate_target(t);
        s_hover = t;
    }
    window_t *hw = (t.kind == T_CLIENT) ? t.win : 0;
    if (hw != s_hover_win) {
        if (s_hover_win && !s_capture) send_mouse(s_hover_win, WM_LEAVE, x, y, 0, 0, 0);
        s_hover_win = hw;
    }
}

static uint32_t s_last_down_ms;
static int s_last_down_x, s_last_down_y;
static target_t s_last_down_t;

static void activate(target_t t) {
    switch (t.kind) {
    case T_CLOSE:  gui_close_window(t.win); break;
    case T_LAUNCH: menu_toggle(0); break;
    case T_TASK:   gui_focus_window(t.win); break;
    case T_MENU:   menu_activate(t.idx); break;
    }
}

static void mouse_down(int x, int y, int buttons) {
    target_t t = pick(x, y);

    uint32_t now = timer_ms();
    int dbl = s_last_down_ms && now - s_last_down_ms < 400 &&
              x - s_last_down_x < 5 && s_last_down_x - x < 5 &&
              y - s_last_down_y < 5 && s_last_down_y - y < 5 && same(t, s_last_down_t);
    s_last_down_ms = dbl ? 0 : (now ? now : 1);
    s_last_down_x = x; s_last_down_y = y; s_last_down_t = t;

    if (s_menu_open && t.kind != T_MENU && t.kind != T_LAUNCH) menu_close();

    if (t.kind != T_ICON && s_icon_sel >= 0) {
        invalidate_target((target_t){ T_ICON, s_icon_sel, 0 });
        s_icon_sel = -1;
    }

    switch (t.kind) {
    case T_MENU: case T_LAUNCH: case T_TASK:
        s_press = t; invalidate_target(t);
        break;
    case T_ICON:
        if (s_icon_sel != t.idx) {
            if (s_icon_sel >= 0) invalidate_target((target_t){ T_ICON, s_icon_sel, 0 });
            s_icon_sel = t.idx;
            invalidate_target(t);
        }
        if (dbl) { APP_LIST[t.idx].open(); s_last_down_ms = 0; }
        break;
    case T_CLOSE:
        gui_focus_window(t.win);
        s_press = t; invalidate_target(t);
        break;
    case T_TITLE:
        gui_focus_window(t.win);
        s_drag = t.win;
        s_drag_dx = x - t.win->x;
        s_drag_dy = y - t.win->y;
        break;
    case T_CLIENT:
        gui_focus_window(t.win);
        s_capture = t.win;
        send_mouse(t.win, WM_DOWN, x, y, buttons, 0, dbl);
        break;
    }
}

static void mouse_up(int x, int y, int buttons) {
    if (s_capture) {
        window_t *w = s_capture;
        s_capture = 0;
        send_mouse(w, WM_UP, x, y, buttons, 0, 0);
    }
    s_drag = 0;
    if (s_press.kind != T_NONE) {
        target_t p = s_press;
        s_press.kind = T_NONE;
        invalidate_target(p);
        if (same(pick(x, y), p)) activate(p);
    }
}

// ---------- окна: действия (меню окна и горячие клавиши) ----------

static void center_window(window_t *w) {
    if (w) move_window(w, (s_w - w->w) / 2, (panel_y() - w->h) / 2);
}

static void send_to_back(window_t *w) {
    if (!w || s_norder < 2) return;
    int i = 0;
    while (i < s_norder && s_order[i] != w) i++;
    if (i == s_norder) return;
    for (; i > 0; i--) s_order[i] = s_order[i - 1];
    s_order[0] = w;
    invalidate_outer(w);
    invalidate_outer(top_window());
    invalidate_panel();
}

static void close_all(void) {
    while (s_norder) gui_close_window(s_order[s_norder - 1]);
}

// ---------- правая кнопка ----------

enum { CTX_CLOSE = 1, CTX_BACK, CTX_CENTER, CTX_CLOSE_ALL = 200 };

static void window_menu_cb(void *ctx, int id) {
    window_t *w = ctx;
    if (id == CTX_CLOSE) gui_close_window(w);
    else if (id == CTX_BACK) send_to_back(w);
    else if (id == CTX_CENTER) center_window(w);
}

static void desktop_menu_cb(void *ctx, int id) {
    (void)ctx;
    if (id == CTX_CLOSE_ALL) close_all();
    else if (id >= 0 && id < APP_COUNT) APP_LIST[id].open();
}

static void context_click(int x, int y) {
    target_t t = pick(x, y);
    if (t.kind == T_MENU) return;
    menu_close();

    gui_menu_item_t it[MAX_MENU];
    int n = 0;
    switch (t.kind) {
    case T_ICON:
        if (s_icon_sel != t.idx) {
            if (s_icon_sel >= 0) invalidate_target((target_t){ T_ICON, s_icon_sel, 0 });
            s_icon_sel = t.idx;
            invalidate_target(t);
        }
        it[n++] = (gui_menu_item_t){ "Open", APP_LIST[t.idx].icon, t.idx };
        gui_popup(x, y, it, n, desktop_menu_cb, 0);
        break;
    case T_NONE:
        for (int i = 0; i < APP_COUNT && n < MAX_MENU - 2; i++)
            it[n++] = (gui_menu_item_t){ APP_LIST[i].label, APP_LIST[i].icon, i };
        it[n++] = (gui_menu_item_t){ 0, -1, 0 };
        it[n++] = (gui_menu_item_t){ "Close All Windows", -1, CTX_CLOSE_ALL };
        gui_popup(x, y, it, n, desktop_menu_cb, 0);
        break;
    case T_TITLE: case T_CLOSE: case T_TASK:
        gui_focus_window(t.win);
        it[n++] = (gui_menu_item_t){ "Close",        -1, CTX_CLOSE };
        it[n++] = (gui_menu_item_t){ "Send to Back", -1, CTX_BACK };
        it[n++] = (gui_menu_item_t){ "Center",       -1, CTX_CENTER };
        gui_popup(x, y, it, n, window_menu_cb, t.win);
        break;
    case T_CLIENT:
        gui_focus_window(t.win);
        send_mouse(t.win, WM_CONTEXT, x, y, MB_RIGHT, 0, 0);
        break;
    }
}

static int s_right;

static void on_mouse(const mouse_event_t *m) {
    int x = m->x, y = m->y;
    int left = m->buttons & MB_LEFT;
    int right = m->buttons & MB_RIGHT;
    int prev = s_left, rprev = s_right;
    s_left = left;
    s_right = right;

    if (m->dz) {
        target_t t = pick(x, y);
        if (t.kind == T_CLIENT) send_mouse(t.win, WM_WHEEL, x, y, m->buttons, m->dz, 0);
    }

    if (right && !rprev && !left) {
        update_hover(x, y);
        context_click(x, y);
    }

    if (left && !prev) {
        update_hover(x, y);
        mouse_down(x, y, m->buttons);
    } else if (!left && prev) {
        mouse_up(x, y, m->buttons);
        update_hover(x, y);
    } else {
        update_hover(x, y);
        if (left && s_drag) move_window(s_drag, x - s_drag_dx, y - s_drag_dy);
        else if (s_capture) send_mouse(s_capture, WM_MOVE, x, y, m->buttons, 0, 0);
        else if (s_hover_win) send_mouse(s_hover_win, WM_MOVE, x, y, m->buttons, 0, 0);
    }

    // меню: подсветка следует за мышью
    if (s_menu_open && s_hover.kind == T_MENU && s_hover.idx >= 0 && s_hover.idx != s_menu_sel)
        s_menu_sel = s_hover.idx;
}

static void on_key(const key_event_t *k) {
    int alt = k->mods & MOD_ALT, ctrl = k->mods & MOD_CTRL, shift = k->mods & MOD_SHIFT;

    if (k->key == KEY_SUPER || (alt && k->key == KEY_F1)) { menu_toggle(1); return; }

    if (s_menu_open) {
        if (k->key == 27) menu_close();
        else if (k->key == KEY_UP) menu_move(-1);
        else if (k->key == KEY_DOWN) menu_move(1);
        else if (k->key == '\n') menu_activate(s_menu_sel);
        return;
    }

    window_t *top = top_window();

    if (alt && ctrl) {                                      // Ctrl+Alt: запуск и перемещение окна
        switch (k->key) {
        case 't': app_launch("terminal"); return;
        case 'f': app_launch("files"); return;
        case 'n': app_launch("notepad"); return;
        case KEY_LEFT:  if (top) move_window(top, top->x - 32, top->y); return;
        case KEY_RIGHT: if (top) move_window(top, top->x + 32, top->y); return;
        case KEY_UP:    if (top) move_window(top, top->x, top->y - 32); return;
        case KEY_DOWN:  if (top) move_window(top, top->x, top->y + 32); return;
        }
    }

    if (alt && !ctrl) {
        if (k->key == KEY_F2) { app_launch("terminal"); return; }
        if (k->key == KEY_F3) { app_launch("files"); return; }
        if (k->key == KEY_F4) { gui_close_window(top); return; }
        if (k->key == 'c')    { center_window(top); return; }
        if (k->key == '\t') {                                // Alt+Tab / Alt+Shift+Tab
            if (shift) send_to_back(top);
            else if (s_norder > 1) gui_focus_window(s_order[0]);
            return;
        }
        if (k->key >= '1' && k->key <= '9') {                // Alt+1..9 - n-е окно
            window_t *tasks[MAX_WINDOWS];
            int n = collect_tasks(tasks), i = k->key - '1';
            if (i < n) gui_focus_window(tasks[i]);
            return;
        }
    }

    if (top && top->app && top->app->key) top->app->key(top, k);
}

// ---------- инициализация и главный цикл ----------

void gui_init(void) {
    s_w = gfx_width();
    s_h = gfx_height();
}

static void update_clock(uint32_t now) {
    static uint32_t last;
    if (last && now - last < 1000) return;
    last = now ? now : 1;

    rtc_get(&s_rtc);
    ksnprintf(s_clock_full, sizeof(s_clock_full), "%02d:%02d:%02d", s_rtc.hour, s_rtc.minute, s_rtc.second);

    char buf[8];
    ksnprintf(buf, sizeof(buf), "%02d:%02d", s_rtc.hour, s_rtc.minute);
    if (strcmp(buf, s_clock) != 0) {
        strlcpy(s_clock, buf, sizeof(s_clock));
        int x, y, w, h;
        clock_rect(&x, &y, &w, &h);
        gui_invalidate(x, y, w, h);
    }
    int hx, hy, hw, hh;
    hud_rect(&hx, &hy, &hw, &hh);
    gui_invalidate(hx, hy, hw, 100);                         // часы, дата, uptime
}

void gui_run(void) {
    int shown_x = -1, shown_y = -1;
    gui_invalidate(0, 0, s_w, s_h);

    for (;;) {
        uint32_t now = timer_ms();
        input_poll();

        key_event_t k;
        while (kbd_pop(&k)) on_key(&k);

        mouse_event_t m;
        while (mouse_pop(&m)) on_mouse(&m);

        for (int i = 0; i < s_norder; i++) {
            window_t *w = s_order[i];
            if (w->app && w->app->tick) w->app->tick(w, now);
        }
        update_clock(now);
        update_hover(mouse_x(), mouse_y());

        int cx = mouse_x(), cy = mouse_y();
        if (s_dirty) {
            gfx_clip_push(s_dx0, s_dy0, s_dx1 - s_dx0, s_dy1 - s_dy0);
            paint_scene();
            gfx_clip_pop();
            gfx_present(s_dx0, s_dy0, s_dx1 - s_dx0, s_dy1 - s_dy0, cx, cy);
            s_dirty = 0;
            shown_x = cx; shown_y = cy;
        } else if (cx != shown_x || cy != shown_y) {
            gfx_present(0, 0, 0, 0, cx, cy);
            shown_x = cx; shown_y = cy;
        }

        __asm__ volatile ("pause");
    }
}
