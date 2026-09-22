#include "apps.h"
#include "gfx.h"
#include "theme.h"
#include "timer.h"
#include "string.h"
#include "version.h"

static window_t *s_win;
static uint32_t  s_last_sec;

static void fmt_uptime(char *buf, int n) {
    uint32_t s = timer_ms() / 1000;
    ksnprintf(buf, (size_t)n, "Uptime: %02d:%02d:%02d", (int)(s / 3600), (int)(s / 60 % 60), (int)(s % 60));
}

static void paint(window_t *w, int x, int y, int cw, int ch) {
    (void)w; (void)ch;
    gfx_fill_rect(x, y, cw, 74, COL_DESKTOP);
    gfx_text_scaled(x + (cw - 5 * 8 * 5) / 2, y + 17, "DedOS", COL_ACCENT, 5);
    gfx_hline(x, y + 74, cw, COL_BORDER);

    int ty = y + 92;
    char buf[40];
    ksnprintf(buf, sizeof(buf), "Version %s", DEDOS_VERSION);
    gfx_text(x + 20, ty, buf, COL_TEXT);
    gfx_text(x + 20, ty + 16, "A small experimental operating system.", COL_TEXT);
    gfx_text(x + 20, ty + 40, "x86 - Ring 0 - flat memory", COL_TEXT_SECONDARY);
    gfx_text(x + 20, ty + 52, "VBE framebuffer 1024x768x32", COL_TEXT_SECONDARY);
    gfx_text(x + 20, ty + 64, "PS/2 keyboard and mouse - RAM filesystem", COL_TEXT_SECONDARY);
    fmt_uptime(buf, sizeof(buf));
    gfx_text(x + 20, ty + 88, buf, COL_TEXT);
}

static void tick(window_t *w, uint32_t now) {
    uint32_t sec = now / 1000;
    if (sec != s_last_sec) {
        s_last_sec = sec;
        gui_invalidate_client(w, 0, 170, w->cw, 20);
    }
}

static void on_close(window_t *w) { (void)w; s_win = 0; }

static const app_t APP = { paint, 0, 0, tick, on_close };

window_t *app_about_open(void) {
    if (s_win) { gui_focus_window(s_win); return s_win; }
    s_win = gui_create_window(&APP, "About DedOS", 380, 210, 0);
    return s_win;
}
