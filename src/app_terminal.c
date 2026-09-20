#include "apps.h"
#include "shell.h"
#include "gfx.h"
#include "theme.h"
#include "timer.h"
#include "string.h"
#include "version.h"

#define T_COLS   80
#define T_ROWS   28
#define T_LINES  400            // строк в scrollback
#define CELL_W   8
#define CELL_H   12
#define PAD      4
#define LINE_MAX 200
#define HIST_N   16
#define MAX_TERMS 4

typedef struct {
    int used;
    window_t *win;
    shell_t sh;

    char    ch[T_LINES][T_COLS];
    uint8_t at[T_LINES][T_COLS];
    int first;                  // самая старая строка (абсолютный номер)
    int row, col;               // куда пишет вывод
    int scroll;                 // на сколько строк прокручено назад

    char prompt[64];
    char line[LINE_MAX];
    int  len, pos;

    char hist[HIST_N][LINE_MAX];
    int  hist_n, hist_i;
    char saved[LINE_MAX];

    int want_close;
    int blink_on;
    uint32_t blink_ms;
} term_t;

static term_t s_terms[MAX_TERMS];

// ---------- вывод в кольцевой буфер ----------

static void clear_row(term_t *t, int r) {
    memset(t->ch[r % T_LINES], ' ', T_COLS);
    memset(t->at[r % T_LINES], SA_NORMAL, T_COLS);
}

static void newline(term_t *t) {
    t->col = 0;
    t->row++;
    clear_row(t, t->row);
    if (t->row - t->first >= T_LINES) t->first = t->row - T_LINES + 1;
}

static void put(term_t *t, char c, int attr) {
    if (c == '\n') { newline(t); return; }
    if (c == '\t') {
        do put(t, ' ', attr); while (t->col % 4);
        return;
    }
    if (c < 32 || c > 126) return;
    if (t->col >= T_COLS) newline(t);
    t->ch[t->row % T_LINES][t->col] = c;
    t->at[t->row % T_LINES][t->col] = (uint8_t)attr;
    t->col++;
}

static void put_str(term_t *t, const char *s, int attr) {
    while (*s) put(t, *s++, attr);
}

static void io_out(void *ctx, const char *s, int attr) { put_str(ctx, s, attr); }

static void io_clear(void *ctx) {
    term_t *t = ctx;
    t->first = t->row;
    t->scroll = 0;
}

static void io_exit(void *ctx) { ((term_t *)ctx)->want_close = 1; }

static const shell_io_t IO = { io_out, io_clear, io_exit };

// ---------- строка ввода ----------

static int live_rows(const term_t *t) {
    return ((int)strlen(t->prompt) + t->len) / T_COLS + 1;
}

// абсолютная строка, на которой нижний край видимой области
static int view_top(const term_t *t) {
    int bottom = t->row + live_rows(t) - 1;
    int top = bottom - T_ROWS + 1 - t->scroll;
    return top < t->first ? t->first : top;
}

static int max_scroll(const term_t *t) {
    int total = t->row + live_rows(t) - t->first;
    return total > T_ROWS ? total - T_ROWS : 0;
}

static void set_scroll(term_t *t, int s) {
    int m = max_scroll(t);
    t->scroll = s < 0 ? 0 : s > m ? m : s;
}

static void make_prompt(term_t *t) {
    shell_prompt(&t->sh, t->prompt, sizeof(t->prompt));
    if (t->col != 0) newline(t);
}

static void redraw(term_t *t) { gui_invalidate_window(t->win); }

static void insert(term_t *t, const char *s, int n) {
    for (int i = 0; i < n && t->len < LINE_MAX - 1; i++) {
        memmove(t->line + t->pos + 1, t->line + t->pos, (size_t)(t->len - t->pos));
        t->line[t->pos++] = s[i];
        t->len++;
    }
    t->line[t->len] = '\0';
}

static void set_line(term_t *t, const char *s) {
    strlcpy(t->line, s, LINE_MAX);
    t->len = t->pos = (int)strlen(t->line);
}

// prompt + введённая строка -> в историю вывода
static void commit_line(term_t *t) {
    put_str(t, t->prompt, SA_ACCENT);
    t->line[t->len] = '\0';
    put_str(t, t->line, SA_NORMAL);
}

static void hist_add(term_t *t, const char *s) {
    if (!s[0]) return;
    if (t->hist_n && strcmp(t->hist[t->hist_n - 1], s) == 0) return;
    if (t->hist_n == HIST_N) {
        memmove(t->hist[0], t->hist[1], (size_t)(HIST_N - 1) * LINE_MAX);
        t->hist_n--;
    }
    strlcpy(t->hist[t->hist_n++], s, LINE_MAX);
}

static void submit(term_t *t) {
    char cmd[LINE_MAX];
    strlcpy(cmd, t->line, sizeof(cmd));

    commit_line(t);
    newline(t);
    hist_add(t, cmd);
    t->hist_i = t->hist_n;
    t->len = t->pos = 0;
    t->line[0] = '\0';

    shell_exec(&t->sh, cmd);
    make_prompt(t);
}

static void interrupt(term_t *t) {
    commit_line(t);
    put_str(t, "^C", SA_DIM);
    newline(t);
    t->len = t->pos = 0;
    t->line[0] = '\0';
    t->hist_i = t->hist_n;
}

static void on_key(window_t *w, const key_event_t *k) {
    term_t *t = w->priv;
    int ctrl = k->mods & MOD_CTRL;
    int nav = (k->key == KEY_PGUP || k->key == KEY_PGDN);

    t->blink_on = 1;
    t->blink_ms = timer_ms();
    if (!nav) t->scroll = 0;

    if (ctrl) {
        switch (k->key) {
        case 'c': interrupt(t); break;
        case 'l': io_clear(t); break;
        case 'u': t->len = t->pos = 0; t->line[0] = '\0'; break;
        case 'a': t->pos = 0; break;
        case 'e': t->pos = t->len; break;
        case 'k': t->len = t->pos; t->line[t->len] = '\0'; break;
        case 'v': {
            const char *c = clipboard_get();
            int n = 0;
            while (c[n] && c[n] != '\n') n++;
            insert(t, c, n);
            break;
        }
        }
        redraw(t);
        return;
    }
    if (k->mods & MOD_ALT) return;

    switch (k->key) {
    case '\n':
        submit(t);
        if (t->want_close) { gui_close_window(w); return; }   // после этого t недействителен
        break;
    case '\b':
        if (t->pos > 0) {
            memmove(t->line + t->pos - 1, t->line + t->pos, (size_t)(t->len - t->pos + 1));
            t->pos--; t->len--;
        }
        break;
    case KEY_DELETE:
        if (t->pos < t->len) {
            memmove(t->line + t->pos, t->line + t->pos + 1, (size_t)(t->len - t->pos));
            t->len--;
        }
        break;
    case KEY_LEFT:  if (t->pos > 0) t->pos--; break;
    case KEY_RIGHT: if (t->pos < t->len) t->pos++; break;
    case KEY_HOME:  t->pos = 0; break;
    case KEY_END:   t->pos = t->len; break;
    case KEY_UP:
        if (t->hist_i > 0) {
            if (t->hist_i == t->hist_n) strlcpy(t->saved, t->line, LINE_MAX);
            set_line(t, t->hist[--t->hist_i]);
        }
        break;
    case KEY_DOWN:
        if (t->hist_i < t->hist_n) {
            t->hist_i++;
            set_line(t, t->hist_i == t->hist_n ? t->saved : t->hist[t->hist_i]);
        }
        break;
    case KEY_PGUP: set_scroll(t, t->scroll + T_ROWS - 2); break;
    case KEY_PGDN: set_scroll(t, t->scroll - (T_ROWS - 2)); break;
    default:
        if (k->key >= 32 && k->key < 127) { char c = (char)k->key; insert(t, &c, 1); }
        else return;
    }
    redraw(t);
}

static void on_mouse(window_t *w, const wmouse_t *m) {
    term_t *t = w->priv;
    if (m->type == WM_WHEEL) { set_scroll(t, t->scroll + m->dz * 3); redraw(t); }
}

// ---------- отрисовка ----------

static uint32_t attr_color(int a) {
    switch (a) {
    case SA_DIM:    return COL_TERM_DIM;
    case SA_ACCENT: return COL_TERM_PROMPT;
    case SA_ERROR:  return COL_TERM_ERROR;
    case SA_DIR:    return COL_TERM_DIR;
    }
    return COL_TERM_TEXT;
}

// клетка курсора в клиентских координатах; 0, если он не виден
static int cursor_cell(const term_t *t, int *px, int *py) {
    if (t->scroll) return 0;
    int cpos = (int)strlen(t->prompt) + t->pos;
    int vis = t->row + cpos / T_COLS - view_top(t);
    if (vis < 0 || vis >= T_ROWS) return 0;
    *px = PAD + (cpos % T_COLS) * CELL_W;
    *py = PAD + vis * CELL_H;
    return 1;
}

static void paint(window_t *w, int x, int y, int cw, int ch) {
    term_t *t = w->priv;
    gfx_fill_rect(x, y, cw, ch, COL_TERM_BG);

    int top = view_top(t);
    int plen = (int)strlen(t->prompt);
    int bottom = t->row + live_rows(t) - 1;

    for (int v = 0; v < T_ROWS; v++) {
        int abs = top + v;
        if (abs > bottom) break;
        int ry = y + PAD + v * CELL_H;
        if (!gfx_visible(x, ry, cw, CELL_H)) continue;

        for (int c = 0; c < T_COLS; c++) {
            char chr = ' ';
            int attr = SA_NORMAL;
            if (abs < t->row) {
                chr = t->ch[abs % T_LINES][c];
                attr = t->at[abs % T_LINES][c];
            } else {
                int idx = (abs - t->row) * T_COLS + c;
                if (idx < plen) { chr = t->prompt[idx]; attr = SA_ACCENT; }
                else if (idx - plen < t->len) chr = t->line[idx - plen];
            }
            if (chr != ' ') gfx_char(x + PAD + c * CELL_W, ry + 2, chr, attr_color(attr), 1);
        }
    }

    int cx, cy;
    if (cursor_cell(t, &cx, &cy)) {
        cx += x; cy += y;
        if (gui_is_focused(w)) {
            if (t->blink_on) {
                gfx_fill_rect(cx, cy, CELL_W, CELL_H, COL_TERM_PROMPT);
                int cpos = plen + t->pos;
                char under = cpos - plen < t->len ? t->line[t->pos] : ' ';
                if (under != ' ') gfx_char(cx, cy + 2, under, COL_TERM_BG, 1);
            }
        } else {
            gfx_rect(cx, cy, CELL_W, CELL_H, COL_TERM_PROMPT);
        }
    }
}

static void tick(window_t *w, uint32_t now) {
    term_t *t = w->priv;
    if (!gui_is_focused(w) || now - t->blink_ms < 500) return;
    t->blink_ms = now;
    t->blink_on = !t->blink_on;
    int cx, cy;
    if (cursor_cell(t, &cx, &cy)) gui_invalidate_client(w, cx, cy, CELL_W, CELL_H);
}

static void on_close(window_t *w) { ((term_t *)w->priv)->used = 0; }

static const app_t APP = { paint, on_key, on_mouse, tick, on_close };

window_t *app_terminal_open(void) {
    term_t *t = 0;
    for (int i = 0; i < MAX_TERMS; i++) if (!s_terms[i].used) { t = &s_terms[i]; break; }
    if (!t) return 0;

    memset(t, 0, sizeof(*t));
    t->used = 1;
    t->blink_on = 1;
    t->blink_ms = timer_ms();
    clear_row(t, 0);
    shell_init(&t->sh, &IO, t, T_COLS);

    put_str(t, "DedOS " DEDOS_VERSION " shell\n", SA_ACCENT);
    put_str(t, "Type 'help' for a list of commands.\n\n", SA_DIM);
    make_prompt(t);

    t->win = gui_create_window(&APP, "Terminal", T_COLS * CELL_W + 2 * PAD, T_ROWS * CELL_H + 2 * PAD, t);
    if (!t->win) t->used = 0;
    return t->win;
}
