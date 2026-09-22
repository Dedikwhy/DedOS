#ifndef THEME_H
#define THEME_H

// Палитра DedOS в стиле HUD: почти чёрный фон, бледно-голубой текст, тонкие линии.
// Все цвета берём только отсюда.

// --- рабочий стол ---
#define COL_DESKTOP        0x070E11
#define COL_DESKTOP_DOT    0x1E353B   // сетка точек на обоях

// --- панель ---
#define COL_PANEL          0x050A0C
#define COL_PANEL_EDGE     0x2D4A50
#define COL_PANEL_TEXT     0xAACFD1
#define COL_PANEL_DIM      0x5B7F84
#define COL_PANEL_BUTTON   0x0B171B
#define COL_PANEL_HOVER    0x16292E

// --- окна ---
#define COL_WINDOW         0x081114   // клиентская область
#define COL_WINDOW_ALT     0x0D1A1E   // шапки, статус-строки
#define COL_TITLE_TEXT     0xD5F3F5
#define COL_TITLE_TEXT_OFF 0x5B7F84
#define COL_BORDER         0x2D4A50   // линии и рамки

// --- текст ---
#define COL_TEXT           0xAACFD1
#define COL_TEXT_SECONDARY 0x5B7F84
#define COL_TEXT_LIGHT     0xAACFD1
#define COL_INK            0x061014   // тёмный текст на светлой заливке

// --- акцент, кнопки, выделение ---
#define COL_ACCENT         0xAACFD1
#define COL_ACCENT_DARK    0x5B7F84
#define COL_ACCENT_HOVER   0xD5F3F5
#define COL_BUTTON         0x0F1D22
#define COL_BUTTON_HOVER   0x1A3238
#define COL_BUTTON_PRESSED 0x2A5158
#define COL_SELECT         0xAACFD1
#define COL_SELECT_TEXT    0x061014
#define COL_HOVER_ROW      0x13262B

// --- терминал ---
#define COL_TERM_BG        0x050B0E
#define COL_TERM_TEXT      0xAACFD1
#define COL_TERM_DIM       0x5B7F84
#define COL_TERM_PROMPT    0xD5F3F5
#define COL_TERM_ERROR     0xE0705A
#define COL_TERM_DIR       0x7FD8E0

// --- геометрия ---
#define PANEL_H   28
#define TITLE_H   20
#define TEXT_H    8      // высота глифа шрифта 8x8

#endif
