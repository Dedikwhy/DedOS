#include "apps.h"
#include "fs.h"
#include "gfx.h"
#include "theme.h"
#include "icons.h"
#include "string.h"
#include "mouse.h"

#define MAX_FILES_WIN 4
#define HIST_N   8
#define TOOL_H   30
#define HEAD_H   18
#define STATUS_H 20
#define ROW_H    18
#define SB_W     14

enum { B_BACK, B_UP, B_HOME, B_COUNT };

typedef struct {
    int used;
    window_t *win;
    char cwd[MAX_PATH];
    char hist[HIST_N][MAX_PATH];
    int  nhist;
    file_t *ents[MAX_FILES];
    int  n;
    int  sel;
    char sel_name[MAX_FILENAME];
    int  top;
    int  hover;                 // строка под мышью
    int  hover_btn, press_btn;
    uint32_t gen;
} files_t;

static files_t s_files[MAX_FILES_WIN];

static int vis_rows(const window_t *w) { return (w->ch - TOOL_H - HEAD_H - STATUS_H) / ROW_H; }
static int list_y(void) { return TOOL_H + HEAD_H; }

static void btn_rect(int b, int *x, int *y, int *w, int *h) {
    static const int bx[B_COUNT] = { 6, 66, 114 };
    static const int bw[B_COUNT] = { 56, 42, 52 };
    *x = bx[b]; *y = 5; *w = bw[b]; *h = 20;
}

static void join(const char *dir, const char *name, char *out) {
    if (strcmp(dir, "/") == 0) ksnprintf(out, MAX_PATH, "/%s", name);
    else ksnprintf(out, MAX_PATH, "%s/%s", dir, name);
}

static void refresh(files_t *f) {
    int n = fs_readdir(f->cwd, f->ents, MAX_FILES);
    if (n < 0) {                                   // каталог исчез
        strlcpy(f->cwd, "/", sizeof(f->cwd));
        n = fs_readdir(f->cwd, f->ents, MAX_FILES);
    }
    f->n = n;
    f->sel = -1;
    for (int i = 0; i < n; i++)
        if (strcmp(f->ents[i]->name, f->sel_name) == 0) f->sel = i;
    if (f->sel < 0) f->sel_name[0] = '\0';
    int vis = vis_rows(f->win);
    if (f->top > n - vis) f->top = n - vis;
    if (f->top < 0) f->top = 0;
    f->hover = -1;
    f->gen = fs_generation();
}

static void set_title(files_t *f) {
    char t[40];
    ksnprintf(t, sizeof(t), "Files - %s", f->cwd);
    gui_set_title(f->win, t);
}

static void navigate(files_t *f, const char *path, int push) {
    if (!fs_is_dir(path)) return;
    if (push && strcmp(path, f->cwd) != 0) {
        if (f->nhist == HIST_N) {
            memmove(f->hist[0], f->hist[1], (size_t)(HIST_N - 1) * MAX_PATH);
            f->nhist--;
        }
        strlcpy(f->hist[f->nhist++], f->cwd, MAX_PATH);
    }
    strlcpy(f->cwd, path, sizeof(f->cwd));
    f->sel_name[0] = '\0';
    f->top = 0;
    refresh(f);
    set_title(f);
    gui_invalidate_window(f->win);
}

static void go_up(files_t *f) {
    char p[MAX_PATH];
    if (strcmp(f->cwd, "/") == 0) return;
    fs_resolve(f->cwd, "..", p);
    navigate(f, p, 1);
}

static void go_back(files_t *f) {
    if (!f->nhist) return;
    char p[MAX_PATH];
    strlcpy(p, f->hist[--f->nhist], sizeof(p));
    navigate(f, p, 0);
}

static void open_entry(files_t *f, int i) {
    if (i < 0 || i >= f->n) return;
    char p[MAX_PATH];
    join(f->cwd, f->ents[i]->name, p);
    if (f->ents[i]->is_dir) navigate(f, p, 1);
    else app_open_path(p);
}

static void select_row(files_t *f, int i) {
    if (i < -1 || i >= f->n) return;
    f->sel = i;
    strlcpy(f->sel_name, i >= 0 ? f->ents[i]->name : "", sizeof(f->sel_name));
    int vis = vis_rows(f->win);
    if (i >= 0) {
        if (i < f->top) f->top = i;
        if (i >= f->top + vis) f->top = i - vis + 1;
    }
    gui_invalidate_window(f->win);
}

static void button_action(files_t *f, int b) {
    if (b == B_BACK) go_back(f);
    else if (b == B_UP) go_up(f);
    else navigate(f, "/home", 1);
}

static int btn_enabled(const files_t *f, int b) {
    if (b == B_BACK) return f->nhist > 0;
    if (b == B_UP) return strcmp(f->cwd, "/") != 0;
    return 1;
}

// ---------- события ----------

static void on_key(window_t *w, const key_event_t *k) {
    files_t *f = w->priv;
    int alt = k->mods & MOD_ALT;
    int vis = vis_rows(w);

    switch (k->key) {
    case KEY_UP:   if (alt) go_up(f); else select_row(f, f->sel < 0 ? f->n - 1 : f->sel - 1 < 0 ? 0 : f->sel - 1); break;
    case KEY_DOWN: select_row(f, f->sel < 0 ? 0 : f->sel + 1 >= f->n ? f->n - 1 : f->sel + 1); break;
    case KEY_HOME: select_row(f, f->n ? 0 : -1); break;
    case KEY_END:  select_row(f, f->n - 1); break;
    case KEY_PGUP: select_row(f, f->sel - vis < 0 ? 0 : f->sel - vis); break;
    case KEY_PGDN: select_row(f, f->sel + vis >= f->n ? f->n - 1 : f->sel + vis); break;
    case KEY_LEFT: if (alt) go_back(f); break;
    case '\n':     open_entry(f, f->sel); break;
    case '\b':     go_up(f); break;
    }
}

static void on_mouse(window_t *w, const wmouse_t *m) {
    files_t *f = w->priv;
    int vis = vis_rows(w);
    int in_list = m->y >= list_y() && m->y < list_y() + vis * ROW_H && m->x < w->cw - (f->n > vis ? SB_W : 0);
    int row = in_list ? f->top + (m->y - list_y()) / ROW_H : -1;
    if (row >= f->n) row = -1;

    int btn = -1;
    for (int b = 0; b < B_COUNT; b++) {
        int x, y, bw, bh;
        btn_rect(b, &x, &y, &bw, &bh);
        if (m->x >= x && m->x < x + bw && m->y >= y && m->y < y + bh) btn = b;
    }

    switch (m->type) {
    case WM_LEAVE:
        row = -1; btn = -1;
        break;
    case WM_WHEEL:
        f->top -= m->dz * 3;
        if (f->top > f->n - vis) f->top = f->n - vis;
        if (f->top < 0) f->top = 0;
        gui_invalidate_window(w);
        break;
    case WM_DOWN:
        if (btn >= 0 && btn_enabled(f, btn)) { f->press_btn = btn; gui_invalidate_window(w); }
        else if (in_list) {
            select_row(f, row);
            if (m->dbl) open_entry(f, row);
        } else if (f->n > vis && m->x >= w->cw - SB_W && m->y >= list_y() && m->y < list_y() + vis * ROW_H) {
            int mid = list_y() + vis * ROW_H / 2;                 // клик по треку - страница вверх/вниз
            f->top += m->y < mid ? -vis : vis;
            if (f->top > f->n - vis) f->top = f->n - vis;
            if (f->top < 0) f->top = 0;
            gui_invalidate_window(w);
        }
        return;
    case WM_UP:
        if (f->press_btn >= 0) {
            int b = f->press_btn;
            f->press_btn = -1;
            gui_invalidate_window(w);
            if (b == btn) button_action(f, b);
        }
        return;
    }

    if (row != f->hover || btn != f->hover_btn) {
        f->hover = row;
        f->hover_btn = btn;
        gui_invalidate_window(w);
    }
}

static void tick(window_t *w, uint32_t now) {
    (void)now;
    files_t *f = w->priv;
    if (f->gen != fs_generation()) { refresh(f); gui_invalidate_window(w); }
}

// ---------- отрисовка ----------

static void draw_button(files_t *f, int b, const char *label, int x, int y, int w, int h) {
    int enabled = btn_enabled(f, b);
    int hover = enabled && f->hover_btn == b;
    int pressed = hover && f->press_btn == b;
    uint32_t bg = pressed ? COL_BUTTON_PRESSED : hover ? COL_BUTTON_HOVER : COL_BUTTON;
    gfx_fill_rect(x, y, w, h, bg);
    gfx_rect(x, y, w, h, COL_BORDER);
    int off = pressed ? 1 : 0;
    gfx_text(x + (w - gfx_text_width(label)) / 2 + off, y + (h - 8) / 2 + off, label,
             enabled ? COL_TEXT : COL_TEXT_SECONDARY);
}

static void paint(window_t *w, int x, int y, int cw, int ch) {
    files_t *f = w->priv;
    int vis = vis_rows(w);

    // панель инструментов
    gfx_fill_rect(x, y, cw, TOOL_H, COL_WINDOW_ALT);
    gfx_hline(x, y + TOOL_H - 1, cw, COL_BORDER);
    static const char *const labels[B_COUNT] = { "< Back", "Up", "Home" };
    for (int b = 0; b < B_COUNT; b++) {
        int bx, by, bw, bh;
        btn_rect(b, &bx, &by, &bw, &bh);
        draw_button(f, b, labels[b], x + bx, y + by, bw, bh);
    }
    int px = x + 174;
    gfx_fill_rect(px, y + 5, cw - 174 - 6, 20, COL_WINDOW);
    gfx_rect(px, y + 5, cw - 174 - 6, 20, COL_BORDER);
    gfx_text_fit(px + 6, y + 5 + 6, f->cwd, COL_TEXT, cw - 174 - 6 - 12);

    // заголовок колонок
    int hy = y + TOOL_H;
    gfx_fill_rect(x, hy, cw, HEAD_H, COL_WINDOW_ALT);
    gfx_hline(x, hy + HEAD_H - 1, cw, COL_TEXT_SECONDARY);
    gfx_text(x + 28, hy + 5, "Name", COL_TEXT_SECONDARY);
    gfx_text(x + cw - SB_W - 60, hy + 5, "Size", COL_TEXT_SECONDARY);

    // список
    int ly = y + list_y();
    int sb = f->n > vis;
    int rw = cw - (sb ? SB_W : 0);
    for (int r = 0; r < vis; r++) {
        int i = f->top + r;
        if (i >= f->n) break;
        int ry = ly + r * ROW_H;
        if (!gfx_visible(x, ry, cw, ROW_H)) continue;
        file_t *e = f->ents[i];
        int sel = (i == f->sel);
        if (sel) gfx_fill_rect(x, ry, rw, ROW_H, COL_SELECT);
        else if (i == f->hover) gfx_fill_rect(x, ry, rw, ROW_H, COL_HOVER_ROW);
        uint32_t fg = sel ? COL_SELECT_TEXT : COL_TEXT;
        int icon = e->is_dir ? ICON_FOLDER : str_ends_with(e->name, ".app") ? ICON_APP : ICON_FILE;
        icon_draw(icon, x + 6, ry + 1, 16);
        gfx_text_fit(x + 28, ry + (ROW_H - 8) / 2, e->name, fg, rw - 28 - 70);
        char sz[16];
        if (e->is_dir) strlcpy(sz, "-", sizeof(sz)); else ksnprintf(sz, sizeof(sz), "%u B", e->size);
        gfx_text(x + rw - 60, ry + (ROW_H - 8) / 2, sz, sel ? COL_SELECT_TEXT : COL_TEXT_SECONDARY);
    }
    if (f->n == 0) gfx_text(x + 28, ly + 6, "(empty)", COL_TEXT_SECONDARY);

    // полоса прокрутки
    if (sb) {
        int sx = x + cw - SB_W, sh = vis * ROW_H;
        gfx_fill_rect(sx, ly, SB_W, sh, COL_WINDOW_ALT);
        gfx_vline(sx, ly, sh, COL_TEXT_SECONDARY);
        int th = sh * vis / f->n;
        if (th < 16) th = 16;
        int ty = ly + (sh - th) * f->top / (f->n - vis);
        gfx_fill_rect(sx + 2, ty, SB_W - 4, th, COL_BUTTON_PRESSED);
        gfx_rect(sx + 2, ty, SB_W - 4, th, COL_BORDER);
    }

    // статус-строка
    int sy = y + ch - STATUS_H;
    gfx_fill_rect(x, sy, cw, STATUS_H, COL_WINDOW_ALT);
    gfx_hline(x, sy, cw, COL_TEXT_SECONDARY);
    char st[64];
    if (f->sel >= 0) {
        file_t *e = f->ents[f->sel];
        if (e->is_dir) ksnprintf(st, sizeof(st), "%s  (folder)", e->name);
        else ksnprintf(st, sizeof(st), "%s  %u bytes", e->name, e->size);
    } else {
        ksnprintf(st, sizeof(st), "%d item%s", f->n, f->n == 1 ? "" : "s");
    }
    gfx_text_fit(x + 8, sy + 6, st, COL_TEXT, cw - 16);
}

static void on_close(window_t *w) { ((files_t *)w->priv)->used = 0; }

static const app_t APP = { paint, on_key, on_mouse, tick, on_close };

window_t *app_files_open(const char *path) {
    files_t *f = 0;
    for (int i = 0; i < MAX_FILES_WIN; i++) if (!s_files[i].used) { f = &s_files[i]; break; }
    if (!f) return 0;

    memset(f, 0, sizeof(*f));
    f->used = 1;
    f->sel = f->hover = f->hover_btn = f->press_btn = -1;
    strlcpy(f->cwd, path && fs_is_dir(path) ? path : "/home", sizeof(f->cwd));

    f->win = gui_create_window(&APP, "Files", 560, 380, f);
    if (!f->win) { f->used = 0; return 0; }
    refresh(f);
    set_title(f);
    return f->win;
}
