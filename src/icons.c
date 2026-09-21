#include "icons.h"
#include "gfx.h"
#include "theme.h"

// Иконки нарисованы в сетке 16x16 и масштабируются целым множителем.
// Плоские, бледно-голубые: заливка COL_ACCENT, детали COL_INK / COL_ACCENT_DARK.

#define R(px, py, pw, ph, c) gfx_fill_rect(x + (px) * k, y + (py) * k, (pw) * k, (ph) * k, (c))

static void page(int x, int y, int k) {
    R(3, 1, 10, 14, COL_ACCENT);
    R(9, 1, 4, 4, COL_ACCENT_DARK);           // загнутый угол
    R(9, 1, 1, 1, COL_WINDOW);
}

void icon_draw(int kind, int x, int y, int size) {
    int k = size / 16;
    if (k < 1) k = 1;

    switch (kind) {
    case ICON_TERMINAL:
        R(1, 2, 14, 12, COL_ACCENT);
        R(2, 4, 12, 9, COL_TERM_BG);
        R(4, 6, 1, 1, COL_ACCENT); R(5, 7, 1, 1, COL_ACCENT); R(4, 8, 1, 1, COL_ACCENT);   // >
        R(7, 9, 4, 1, COL_ACCENT);                                                          // _
        break;
    case ICON_FILES:
    case ICON_FOLDER:
        R(1, 3, 6, 3, COL_ACCENT_DARK);       // ушко
        R(1, 5, 14, 9, COL_ACCENT);
        R(1, 5, 14, 1, COL_ACCENT_HOVER);
        break;
    case ICON_NOTEPAD:
        page(x, y, k);
        R(5, 7, 6, 1, COL_INK);
        R(5, 9, 6, 1, COL_INK);
        R(5, 11, 4, 1, COL_INK);
        break;
    case ICON_FILE:
        page(x, y, k);
        R(6, 8, 5, 1, COL_INK);
        R(6, 10, 5, 1, COL_INK);
        break;
    case ICON_APP:
        R(2, 2, 12, 12, COL_ACCENT);
        R(5, 5, 6, 6, COL_INK);
        R(6, 6, 4, 4, COL_ACCENT_DARK);
        break;
    case ICON_ABOUT:
        R(2, 2, 12, 12, COL_ACCENT);
        R(7, 4, 2, 2, COL_INK);               // «i»
        R(7, 7, 2, 5, COL_INK);
        break;
    case ICON_POWER:
        R(2, 2, 12, 12, COL_ACCENT);
        R(7, 3, 2, 5, COL_INK);
        R(5, 7, 1, 4, COL_INK); R(10, 7, 1, 4, COL_INK); R(6, 11, 4, 1, COL_INK);
        break;
    case ICON_RESTART:
        R(2, 2, 12, 12, COL_ACCENT);
        R(5, 5, 6, 1, COL_INK); R(5, 5, 1, 6, COL_INK); R(5, 10, 6, 1, COL_INK);
        R(10, 7, 1, 4, COL_INK);
        break;
    }
}
