#include "apps.h"
#include "fs.h"
#include "gfx.h"
#include "theme.h"
#include "timer.h"
#include "string.h"

#define MAX_PADS  4
#define PAD       6
#define CELL_W    8
#define CELL_H    12
#define STATUS_H  20
#define NP_COLS   66
#define NP_ROWS   26

typedef struct {
    int used;
    window_t *win;
    char path[MAX_PATH];             // пусто - документ без имени
    char buf[MAX_FILE_SIZE];
    int  len, cur;
    int  top;                        // первая видимая визуальная строка
    int  modified;
    char msg[40];
    int  blink_on;
    uint32_t blink_ms;
} pad_t;

static pad_t s_pads[MAX_PADS];

// ---------- буфер обмена ----------

static char s_clip[256];
const char *clipboard_get(void) { return s_clip; }
void clipboard_set(const char *s, int n) {
    if (n > (int)sizeof(s_clip) - 1) n = (int)sizeof(s_clip) - 1;
    memcpy(s_clip, s, (size_t)n);
    s_clip[n] = '\0';
}

// ---------- раскладка текста ----------
// Текст переносится по NP_COLS; '\n' начинает новую строку.

static void layout_of(const pad_t *p, int index, int *row, int *col) {
    int r = 0, c = 0;
    for (int i = 0; i < index; i++) {
        if (p->buf[i] == '\n') { r++; c = 0; }
        else { if (c == NP_COLS) { r++; c = 0; } c++; }
    }
    if (c == NP_COLS && index < p->len && p->buf[index] != '\n') { r++; c = 0; }
    *row = r; *col = c;
}

static int line_start(const pad_t *p, int i) {
    while (i > 0 && p->buf[i - 1] != '\n') i--;
    return i;
}

static int line_end(const pad_t *p, int i) {
    while (i < p->len && p->buf[i] != '\n') i++;
    return i;
}

static int total_rows(const pad_t *p) {
    int r, c;
    layout_of(p, p->len, &r, &c);
    return r + 1;
}

static void touch(pad_t *p) {
    p->modified = 1;
    p->msg[0] = '\0';
    p->blink_on = 1;
    p->blink_ms = timer_ms();
}

static void update_title(pad_t *p) {
    char t[40];
    const char *name = p->path[0] ? fs_basename(p->path) : "Untitled";
    ksnprintf(t, sizeof(t), "Notepad - %s%s", name, p->modified ? "*" : "");
    gui_set_title(p->win, t);
}

static void scroll_to_cursor(pad_t *p) {
    int r, c;
    layout_of(p, p->cur, &r, &c);
    if (r < p->top) p->top = r;
    if (r >= p->top + NP_ROWS) p->top = r - NP_ROWS + 1;
}

static void insert(pad_t *p, const char *s, int n) {
    for (int i = 0; i < n && p->len < MAX_FILE_SIZE - 1; i++) {
        memmove(p->buf + p->cur + 1, p->buf + p->cur, (size_t)(p->len - p->cur));
        p->buf[p->cur++] = s[i];
        p->len++;
    }
    p->buf[p->len] = '\0';
}

static void erase(pad_t *p, int from, int to) {
    memmove(p->buf + from, p->buf + to, (size_t)(p->len - to + 1));
    p->len -= to - from;
    p->cur = from;
}

static void save(pad_t *p) {
    if (!p->path[0]) {                               // без имени -> /home/note.txt, note2.txt ...
        for (int i = 1; i < 100; i++) {
            if (i == 1) strlcpy(p->path, "/home/note.txt", sizeof(p->path));
            else ksnprintf(p->path, sizeof(p->path), "/home/note%d.txt", i);
            if (!fs_stat(p->path)) break;
        }
    }
    if (!fs_stat(p->path) && fs_create(p->path) < 0) {
        strlcpy(p->msg, "Cannot create file", sizeof(p->msg));
        p->path[0] = '\0';
        return;
    }
    fs_write(p->path, p->buf, (uint32_t)p->len);
    p->modified = 0;
    strlcpy(p->msg, "Saved", sizeof(p->msg));
}

// ---------- события ----------

static void move_vertical(pad_t *p, int dir) {
    int ls = line_start(p, p->cur);
    int col = p->cur - ls;
    if (dir < 0) {
        if (ls == 0) { p->cur = 0; return; }
        int pe = ls - 1, ps = line_start(p, pe);
        p->cur = ps + (col < pe - ps ? col : pe - ps);
    } else {
        int le = line_end(p, p->cur);
        if (le >= p->len) { p->cur = p->len; return; }
        int ns = le + 1, ne = line_end(p, ns);
        p->cur = ns + (col < ne - ns ? col : ne - ns);
    }
}

static void on_key(window_t *w, const key_event_t *k) {
    pad_t *p = w->priv;
    int was_mod = p->modified;
    int ctrl = k->mods & MOD_CTRL;

    p->blink_on = 1;
    p->blink_ms = timer_ms();
    p->msg[0] = '\0';

    if (ctrl) {
        switch (k->key) {
        case 's': save(p); break;
        case 'c': case 'x': {
            int s = line_start(p, p->cur), e = line_end(p, p->cur);
            clipboard_set(p->buf + s, e - s);
            if (k->key == 'x') { erase(p, s, e < p->len ? e + 1 : e); touch(p); }
            else strlcpy(p->msg, "Line copied", sizeof(p->msg));
            break;
        }
        case 'v': {
            const char *c = clipboard_get();
            int n = (int)strlen(c);
            if (n) { insert(p, c, n); touch(p); }
            break;
        }
        default: return;
        }
    } else if (!(k->mods & MOD_ALT)) {
        switch (k->key) {
        case KEY_LEFT:  if (p->cur > 0) p->cur--; break;
        case KEY_RIGHT: if (p->cur < p->len) p->cur++; break;
        case KEY_UP:    move_vertical(p, -1); break;
        case KEY_DOWN:  move_vertical(p, 1); break;
        case KEY_HOME:  p->cur = line_start(p, p->cur); break;
        case KEY_END:   p->cur = line_end(p, p->cur); break;
        case KEY_PGUP:  for (int i = 0; i < NP_ROWS - 2; i++) move_vertical(p, -1); break;
        case KEY_PGDN:  for (int i = 0; i < NP_ROWS - 2; i++) move_vertical(p, 1); break;
        case '\b':      if (p->cur > 0) { erase(p, p->cur - 1, p->cur); touch(p); } break;
        case KEY_DELETE: if (p->cur < p->len) { erase(p, p->cur, p->cur + 1); touch(p); } break;
        case '\t':      insert(p, "    ", 4); touch(p); break;
        case '\n':      insert(p, "\n", 1); touch(p); break;
        default:
            if (k->key >= 32 && k->key < 127) { char c = (char)k->key; insert(p, &c, 1); touch(p); }
            else return;
        }
    } else return;

    scroll_to_cursor(p);
    if (p->modified != was_mod || ctrl) update_title(p);
    gui_invalidate_window(w);
}

enum { NC_SAVE = 1, NC_COPY, NC_CUT, NC_PASTE };

static void ctx_cb(void *ctx, int id) {
    static const char keys[] = { 0, 's', 'c', 'x', 'v' };
    key_event_t k = { (uint16_t)keys[id], MOD_CTRL };
    on_key(ctx, &k);
}

static void on_mouse(window_t *w, const wmouse_t *m) {
    pad_t *p = w->priv;
    if (m->type == WM_CONTEXT) {
        gui_menu_item_t it[4] = {
            { "Save",      -1, NC_SAVE },
            { "Copy Line", -1, NC_COPY },
            { "Cut Line",  -1, NC_CUT },
            { "Paste",     -1, NC_PASTE },
        };
        gui_popup(gui_client_x(w) + m->x, gui_client_y(w) + m->y, it, 4, ctx_cb, w);
    } else if (m->type == WM_WHEEL) {
        p->top -= m->dz * 3;
        int max = total_rows(p) - 1;
        if (p->top > max) p->top = max;
        if (p->top < 0) p->top = 0;
        gui_invalidate_window(w);
    } else if (m->type == WM_DOWN && m->y >= 0 && m->y < w->ch - STATUS_H) {
        // клик ставит курсор: ищем индекс по визуальной позиции
        int row = p->top + (m->y - PAD) / CELL_H;
        int col = (m->x - PAD + CELL_W / 2) / CELL_W;
        if (col < 0) col = 0;
        int best = p->len;
        for (int i = 0; i <= p->len; i++) {
            int r, c;
            layout_of(p, i, &r, &c);
            if (r == row && c >= col) { best = i; break; }
            if (r > row) { best = i > 0 ? i - 1 : 0; break; }
        }
        p->cur = best;
        p->blink_on = 1;
        p->blink_ms = timer_ms();
        gui_invalidate_window(w);
    }
}

static void tick(window_t *w, uint32_t now) {
    pad_t *p = w->priv;
    if (!gui_is_focused(w) || now - p->blink_ms < 500) return;
    p->blink_ms = now;
    p->blink_on = !p->blink_on;
    gui_invalidate_window(w);
}

// ---------- отрисовка ----------

static void paint(window_t *w, int x, int y, int cw, int ch) {
    pad_t *p = w->priv;

    int r = 0, c = 0;
    int cur_r = 0, cur_c = 0;
    for (int i = 0; i <= p->len; i++) {
        if (c == NP_COLS && (i < p->len && p->buf[i] != '\n')) { r++; c = 0; }
        if (i == p->cur) { cur_r = r; cur_c = c; }
        if (i == p->len) break;
        char chr = p->buf[i];
        if (chr == '\n') { r++; c = 0; continue; }
        int vr = r - p->top;
        if (vr >= 0 && vr < NP_ROWS)
            gfx_char(x + PAD + c * CELL_W, y + PAD + vr * CELL_H + 2, chr >= 32 && chr < 127 ? chr : '?', COL_TEXT, 1);
        c++;
    }

    int vr = cur_r - p->top;
    if (vr >= 0 && vr < NP_ROWS) {
        int cx = x + PAD + cur_c * CELL_W, cy = y + PAD + vr * CELL_H;
        if (gui_is_focused(w)) { if (p->blink_on) gfx_fill_rect(cx, cy, 2, CELL_H, COL_TEXT); }
        else gfx_rect(cx, cy, CELL_W, CELL_H, COL_TEXT_SECONDARY);
    }

    // статус-строка
    int sy = y + ch - STATUS_H;
    gfx_fill_rect(x, sy, cw, STATUS_H, COL_WINDOW_ALT);
    gfx_hline(x, sy, cw, COL_TEXT_SECONDARY);
    char st[80];
    int ln = 1;
    for (int i = 0; i < p->cur; i++) if (p->buf[i] == '\n') ln++;
    ksnprintf(st, sizeof(st), "Ln %d, Col %d   %d/%d bytes", ln, p->cur - line_start(p, p->cur) + 1, p->len, MAX_FILE_SIZE - 1);
    gfx_text_fit(x + 8, sy + 6, st, COL_TEXT_SECONDARY, cw - 130);
    if (p->msg[0]) gfx_text(x + cw - 8 - gfx_text_width(p->msg), sy + 6, p->msg, COL_TEXT);
    else if (p->modified) gfx_text(x + cw - 8 - 8 * 8, sy + 6, "modified", COL_TEXT_SECONDARY);
}

static void on_close(window_t *w) { ((pad_t *)w->priv)->used = 0; }

static const app_t APP = { paint, on_key, on_mouse, tick, on_close };

window_t *app_notepad_open(const char *path) {
    pad_t *p = 0;
    for (int i = 0; i < MAX_PADS; i++) if (!s_pads[i].used) { p = &s_pads[i]; break; }
    if (!p) return 0;

    memset(p, 0, sizeof(*p));
    p->used = 1;
    p->blink_on = 1;
    p->blink_ms = timer_ms();

    if (path) {
        strlcpy(p->path, path, sizeof(p->path));
        file_t *f = fs_stat(path);
        if (f && !f->is_dir) {
            p->len = (int)f->size;
            memcpy(p->buf, f->data, f->size);
            p->buf[p->len] = '\0';
        }
    }

    p->win = gui_create_window(&APP, "Notepad", NP_COLS * CELL_W + 2 * PAD, NP_ROWS * CELL_H + 2 * PAD + STATUS_H, p);
    if (!p->win) { p->used = 0; return 0; }
    update_title(p);
    return p->win;
}
