#ifndef ICONS_H
#define ICONS_H

enum { ICON_TERMINAL, ICON_FILES, ICON_NOTEPAD, ICON_ABOUT, ICON_FOLDER, ICON_FILE, ICON_APP, ICON_POWER, ICON_RESTART };

// Рисует иконку в квадрате size x size (size кратен 16). Всё собрано из прямоугольников.
void icon_draw(int kind, int x, int y, int size);

#endif
