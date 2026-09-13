#include "gui.h"
#include "gfx.h"
#include "vbe.h"
#include "mouse.h"

// ---------- палитра (совпадает с 16 цветами VGA_COLOR_*) ----------
static const uint32_t PALETTE[16] = {
    0x000000, 0x0000AA, 0x00AA00, 0x00AAAA,
    0xAA0000, 0xAA00AA, 0xAA5500, 0xAAAAAA,
    0x555555, 0x5555FF, 0x55FF55, 0x55FFFF,
    0xFF5555, 0xFF55FF, 0xFFFF55, 0xFFFFFF,
};

// ---------- параметры рабочего стола ----------
#define TASKBAR_H      32
#define TITLEBAR_H     22
#define BORDER         2
#define PADDING        6
#define DESKTOP_BG     0x1B2A3A
#define TASKBAR_BG     0x0D141C
#define BORDER_COLOR   0x0A0F16
#define TITLEBAR_COLOR 0x2C5FAA
#define CLIENT_BG      0x000000

static const char *WINDOW_TITLE = "DedOS Terminal";

// ---------- окно терминала ----------
typedef struct {
    int x, y, w, h;
    int dragging;
    int drag_dx, drag_dy;
} window_t;

static window_t win;

#define MAX_COLS 140
#define MAX_ROWS 80

static char    text_buf[MAX_ROWS][MAX_COLS];
static uint8_t attr_buf[MAX_ROWS][MAX_COLS];
static int cols = 0;
static int rows = 0;
static int cur_col = 0;
static int cur_row = 0;
static uint8_t cur_attr = 0x0F; // белый на чёрном по умолчанию

static int gui_ready = 0;

// ---------- курсор мыши (стрелка 16x16) ----------
static const uint16_t CURSOR_BITMAP[16] = {
    0x8000, 0xC000, 0xE000, 0xF000,
    0xF800, 0xFC00, 0xFE00, 0xFF00,
    0xFF80, 0xF800, 0xD800, 0x8C00,
    0x0C00, 0x0600, 0x0600, 0x0000,
};

static uint32_t cursor_backup[16 * 16];
static int cursor_backed_up = 0;
static int cursor_last_x = -1000, cursor_last_y = -1000;
static int prev_left_button = 0;

static void attr_to_colors(uint8_t attr, uint32_t *fg, uint32_t *bg) {
    *fg = PALETTE[attr & 0x0F];
    *bg = PALETTE[(attr >> 4) & 0x0F];
}

static void clear_text_buffer(void) {
    for (int r = 0; r < MAX_ROWS; r++) {
        for (int c = 0; c < MAX_COLS; c++) {
            text_buf[r][c] = ' ';
            attr_buf[r][c] = cur_attr;
        }
    }
    cur_col = 0;
    cur_row = 0;
}

static void draw_taskbar(void) {
    int w = (int)gfx_width();
    int h = (int)gfx_height();
    gfx_fill_rect(0, h - TASKBAR_H, w, TASKBAR_H, TASKBAR_BG);
    gfx_draw_string(10, h - TASKBAR_H + (TASKBAR_H - 8) / 2, "DedOS", 0xFFFFFF, TASKBAR_BG, 1);
    gfx_draw_string(w / 2 - 60, h - TASKBAR_H + (TASKBAR_H - 8) / 2, WINDOW_TITLE, 0xAAAAAA, TASKBAR_BG, 1);
}

static void draw_desktop_background(void) {
    gfx_fill_rect(0, 0, (int)gfx_width(), (int)gfx_height(), DESKTOP_BG);
    draw_taskbar();
}

// Перерисовывает содержимое клиентской области окна из текстового буфера
static void redraw_window_content(void) {
    int client_x = win.x + BORDER + PADDING;
    int client_y = win.y + BORDER + TITLEBAR_H + PADDING;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            uint32_t fg, bg;
            attr_to_colors(attr_buf[r][c], &fg, &bg);
            gfx_draw_char(client_x + c * 8, client_y + r * 8, text_buf[r][c], fg, bg, 1);
        }
    }
}

static void redraw_window(void) {
    gfx_fill_rect(win.x, win.y, win.w, win.h, BORDER_COLOR);
    gfx_fill_rect(win.x + BORDER, win.y + BORDER, win.w - 2 * BORDER, TITLEBAR_H, TITLEBAR_COLOR);
    gfx_draw_string(win.x + BORDER + 6, win.y + BORDER + (TITLEBAR_H - 8) / 2,
                     WINDOW_TITLE, 0xFFFFFF, TITLEBAR_COLOR, 1);

    int client_w = win.w - 2 * BORDER;
    int client_h = win.h - 2 * BORDER - TITLEBAR_H;
    gfx_fill_rect(win.x + BORDER, win.y + BORDER + TITLEBAR_H, client_w, client_h, CLIENT_BG);

    redraw_window_content();
}

static void move_window(int new_x, int new_y) {
    int old_x = win.x, old_y = win.y;

    gfx_fill_rect(old_x, old_y, win.w, win.h, DESKTOP_BG);

    win.x = new_x;
    win.y = new_y;

    if (old_y + win.h > (int)gfx_height() - TASKBAR_H) {
        draw_taskbar();
    }

    redraw_window();
}

static void restore_cursor(void) {
    if (!cursor_backed_up) return;
    for (int row_ = 0; row_ < 16; row_++) {
        for (int col_ = 0; col_ < 16; col_++) {
            gfx_put_pixel(cursor_last_x + col_, cursor_last_y + row_,
                          cursor_backup[row_ * 16 + col_]);
        }
    }
    cursor_backed_up = 0;
}

static void draw_cursor(int x, int y) {
    for (int row_ = 0; row_ < 16; row_++) {
        for (int col_ = 0; col_ < 16; col_++) {
            cursor_backup[row_ * 16 + col_] = gfx_get_pixel(x + col_, y + row_);
        }
    }
    cursor_backed_up = 1;
    cursor_last_x = x;
    cursor_last_y = y;

    for (int row_ = 0; row_ < 16; row_++) {
        uint16_t bits = CURSOR_BITMAP[row_];
        for (int col_ = 0; col_ < 16; col_++) {
            if (bits & (0x8000 >> col_)) {
                gfx_put_pixel(x + col_, y + row_, 0xFFFFFF);
            }
        }
    }
}

// ---------- публичный API ----------

void gui_init(void) {
    const vbe_info_t *info = vbe_get_info();
    gfx_set_framebuffer(info->fb, info->width, info->height, info->pitch);

    win.w = 820;
    win.h = 560;
    if (win.w > (int)gfx_width() - 20)  win.w = (int)gfx_width() - 20;
    if (win.h > (int)gfx_height() - TASKBAR_H - 20) win.h = (int)gfx_height() - TASKBAR_H - 20;
    win.x = ((int)gfx_width() - win.w) / 2;
    win.y = ((int)gfx_height() - TASKBAR_H - win.h) / 2;
    win.dragging = 0;

    int client_w = win.w - 2 * BORDER - 2 * PADDING;
    int client_h = win.h - 2 * BORDER - TITLEBAR_H - 2 * PADDING;
    cols = client_w / 8;
    rows = client_h / 8;
    if (cols > MAX_COLS) cols = MAX_COLS;
    if (rows > MAX_ROWS) rows = MAX_ROWS;

    clear_text_buffer();

    draw_desktop_background();
    redraw_window();

    mouse_init();
    draw_cursor(mouse_get_x(), mouse_get_y());

    gui_ready = 1;
}

static void scroll_up(void) {
    for (int r = 0; r < rows - 1; r++) {
        for (int c = 0; c < cols; c++) {
            text_buf[r][c] = text_buf[r + 1][c];
            attr_buf[r][c] = attr_buf[r + 1][c];
        }
    }
    for (int c = 0; c < cols; c++) {
        text_buf[rows - 1][c] = ' ';
        attr_buf[rows - 1][c] = cur_attr;
    }
    redraw_window_content();
}

static void put_char_at(int r, int c, char ch) {
    if (r < 0 || r >= rows || c < 0 || c >= cols) return;
    text_buf[r][c] = ch;
    attr_buf[r][c] = cur_attr;

    int client_x = win.x + BORDER + PADDING;
    int client_y = win.y + BORDER + TITLEBAR_H + PADDING;
    uint32_t fg, bg;
    attr_to_colors(cur_attr, &fg, &bg);
    gfx_draw_char(client_x + c * 8, client_y + r * 8, ch, fg, bg, 1);
}

void gui_putchar(char c) {
    if (!gui_ready) return;

    if (c == '\n') {
        cur_col = 0;
        cur_row++;
    } else if (c == '\r') {
        cur_col = 0;
    } else if (c == '\b') {
        if (cur_col > 0) {
            cur_col--;
            put_char_at(cur_row, cur_col, ' ');
        }
    } else if (c == '\t') {
        cur_col = (cur_col + 4) & ~3;
    } else {
        put_char_at(cur_row, cur_col, c);
        cur_col++;
    }

    if (cur_col >= cols) {
        cur_col = 0;
        cur_row++;
    }

    if (cur_row >= rows) {
        scroll_up();
        cur_row = rows - 1;
    }
}

void gui_clear_terminal(void) {
    if (!gui_ready) return;
    clear_text_buffer();
    int client_w = win.w - 2 * BORDER;
    int client_h = win.h - 2 * BORDER - TITLEBAR_H;
    gfx_fill_rect(win.x + BORDER, win.y + BORDER + TITLEBAR_H, client_w, client_h, CLIENT_BG);
}

void gui_setcolor(unsigned char vga_attr) {
    cur_attr = vga_attr;
}

void gui_on_mouse_update(int x, int y, int left_button) {
    if (!gui_ready) return;

    // Сначала убираем курсор с прежнего места - до того, как окно
    // (если оно двигается) перерисует экран под ним.
    restore_cursor();

    int titlebar_hit = (x >= win.x && x < win.x + win.w &&
                         y >= win.y && y < win.y + BORDER + TITLEBAR_H);

    if (!win.dragging && left_button && !prev_left_button && titlebar_hit) {
        win.dragging = 1;
        win.drag_dx = x - win.x;
        win.drag_dy = y - win.y;
    }

    if (win.dragging && left_button) {
        int new_x = x - win.drag_dx;
        int new_y = y - win.drag_dy;

        if (new_x < 0) new_x = 0;
        if (new_y < 0) new_y = 0;
        if (new_x + win.w > (int)gfx_width())  new_x = (int)gfx_width() - win.w;
        if (new_y + win.h > (int)gfx_height() - TASKBAR_H) new_y = (int)gfx_height() - TASKBAR_H - win.h;

        if (new_x != win.x || new_y != win.y) {
            move_window(new_x, new_y);
        }
    } else {
        win.dragging = 0;
    }

    prev_left_button = left_button;

    draw_cursor(x, y);
}
