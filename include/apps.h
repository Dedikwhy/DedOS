#ifndef APPS_H
#define APPS_H

#include "gui.h"

window_t *app_terminal_open(void);
window_t *app_files_open(const char *path);      // NULL -> /home
window_t *app_notepad_open(const char *path);    // NULL -> пустой документ
window_t *app_about_open(void);

// Каталог приложений: используется рабочим столом, меню и командой `run`.
typedef struct {
    const char *name;        // "terminal" - имя в /apps/<name>.app и для команды run
    const char *label;       // "Terminal" - как показывать
    int icon;
    window_t *(*open)(void);
} app_entry_t;

extern const app_entry_t APP_LIST[];
extern const int APP_COUNT;

window_t *app_launch(const char *name);          // по имени; NULL, если такого нет
// Открыть путь "как система": каталог -> Files, *.app -> приложение, остальное -> Notepad.
// Возвращает 0 при успехе, -1 если пути нет.
int app_open_path(const char *abs);

// Общий буфер обмена (Notepad копирует строку, Terminal вставляет по Ctrl+V).
const char *clipboard_get(void);
void clipboard_set(const char *s, int n);

#endif
