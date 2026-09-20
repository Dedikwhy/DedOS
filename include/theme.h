#ifndef THEME_H
#define THEME_H

// Палитра DedOS: тёмный сланцевый рабочий стол, бумажные окна, один акцент - янтарь.
// Все цвета берём только отсюда.

// --- рабочий стол ---
#define COL_DESKTOP        0x2A3B40
#define COL_DESKTOP_DOT    0x2E4046   // второй тон шахматного узора обоев
#define COL_DESKTOP_MARK   0x35494F   // логотип на обоях

// --- панель и меню ---
#define COL_PANEL          0x1B2124
#define COL_PANEL_EDGE     0x364247
#define COL_PANEL_TEXT     0xE4E1D6
#define COL_PANEL_DIM      0x8C9A9E
#define COL_PANEL_BUTTON   0x2B363A
#define COL_PANEL_HOVER    0x3B4A50

// --- окна ---
#define COL_WINDOW         0xDCD8CA   // «бумага»: фон клиентской области
#define COL_WINDOW_ALT     0xCFCBBC   // шапки, статус-строки
#define COL_TITLE_ACTIVE   0xE0A030
#define COL_TITLE_STRIPE   0xB9822A
#define COL_TITLE_INACTIVE 0xA9AEA6
#define COL_TITLE_TEXT     0x1B2124
#define COL_TITLE_TEXT_OFF 0x4E5652
#define COL_BORDER         0x0F1315

// --- текст ---
#define COL_TEXT           0x1B2124   // на бумаге
#define COL_TEXT_SECONDARY 0x6B716E
#define COL_TEXT_LIGHT     0xE4E1D6   // на тёмном
#define COL_TEXT_LIGHT_DIM 0x8C9A9E

// --- акцент, кнопки, выделение ---
#define COL_ACCENT         0xE0A030
#define COL_ACCENT_DARK    0xB9822A
#define COL_ACCENT_HOVER   0xEDB84E
#define COL_BUTTON         0xC7C3B4
#define COL_BUTTON_HOVER   0xE8E4D6
#define COL_BUTTON_PRESSED 0xADA999
#define COL_SELECT         0xE0A030
#define COL_SELECT_TEXT    0x1B2124
#define COL_HOVER_ROW      0xE8E4D6

// --- терминал ---
#define COL_TERM_BG        0x151A1C
#define COL_TERM_TEXT      0xD6DAD0
#define COL_TERM_DIM       0x7C878B
#define COL_TERM_PROMPT    0xE0A030
#define COL_TERM_ERROR     0xE0705A
#define COL_TERM_DIR       0x7FB5C9

// --- геометрия ---
#define PANEL_H   28
#define TITLE_H   20
#define TEXT_H    8      // высота глифа шрифта 8x8

#endif
