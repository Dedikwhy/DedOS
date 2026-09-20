#include "icons.h"
#include "gfx.h"
#include "theme.h"

// Иконки нарисованы в сетке 16x16 и масштабируются целым множителем.

#define R(px, py, pw, ph, c) gfx_fill_rect(x + (px) * k, y + (py) * k, (pw) * k, (ph) * k, (c))

static void page(int x, int y, int k, uint32_t fill) {
    R(3, 1, 10, 14, COL_BORDER);
    R(4, 2, 8, 12, fill);
    R(9, 1, 4, 4, COL_BORDER);                // загнутый угол
    R(9, 2, 3, 3, COL_WINDOW_ALT);
}

void icon_draw(int kind, int x, int y, int size) {
    int k = size / 16;
    if (k < 1) k = 1;

    switch (kind) {
    case ICON_TERMINAL:
        R(1, 2, 14, 12, COL_BORDER);
        R(2, 4, 12, 9, COL_TERM_BG);
        R(2, 3, 12, 1, COL_ACCENT);           // «заголовок»
        R(4, 6, 1, 1, COL_ACCENT); R(5, 7, 1, 1, COL_ACCENT); R(4, 8, 1, 1, COL_ACCENT);   // >
        R(7, 9, 4, 1, COL_TERM_TEXT);                                                       // _
        break;
    case ICON_FILES:
    case ICON_FOLDER:
        R(1, 3, 6, 3, COL_BORDER);            // ушко
        R(1, 5, 14, 9, COL_BORDER);
        R(2, 4, 4, 2, COL_ACCENT_DARK);
        R(2, 6, 12, 7, COL_ACCENT);
        R(2, 6, 12, 1, 0xF0C060);
        break;
    case ICON_NOTEPAD:
        page(x, y, k, COL_WINDOW);
        R(6, 6, 5, 1, COL_TEXT_SECONDARY);
        R(6, 8, 5, 1, COL_TEXT_SECONDARY);
        R(6, 10, 3, 1, COL_TEXT_SECONDARY);
        R(3, 1, 3, 2, COL_ACCENT);            // янтарная «скрепка» сверху
        break;
    case ICON_FILE:
        page(x, y, k, COL_WINDOW);
        R(6, 7, 5, 1, COL_TEXT_SECONDARY);
        R(6, 9, 5, 1, COL_TEXT_SECONDARY);
        break;
    case ICON_APP:
        R(2, 2, 12, 12, COL_BORDER);
        R(3, 3, 10, 10, COL_ACCENT);
        R(5, 5, 6, 6, COL_BORDER);
        R(6, 6, 4, 4, COL_TERM_BG);
        break;
    case ICON_ABOUT:
        R(2, 2, 12, 12, COL_BORDER);
        R(3, 3, 10, 10, COL_TERM_BG);
        R(7, 4, 2, 2, COL_ACCENT);            // «i»
        R(7, 7, 2, 5, COL_ACCENT);
        break;
    case ICON_POWER:
        R(2, 2, 12, 12, COL_BORDER);
        R(3, 3, 10, 10, COL_TERM_ERROR);
        R(7, 4, 2, 5, COL_BORDER);
        R(5, 8, 1, 3, COL_BORDER); R(10, 8, 1, 3, COL_BORDER); R(6, 11, 4, 1, COL_BORDER);
        break;
    case ICON_RESTART:
        R(2, 2, 12, 12, COL_BORDER);
        R(3, 3, 10, 10, COL_ACCENT);
        R(5, 5, 6, 1, COL_BORDER); R(5, 5, 1, 6, COL_BORDER); R(5, 10, 6, 1, COL_BORDER);
        R(10, 7, 1, 4, COL_BORDER);
        break;
    }
}
