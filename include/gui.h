#ifndef GUI_H
#define GUI_H

#include "keyboard.h"

// Окно = рамка + заголовок (рисует GUI) + клиентская область (рисует приложение).
// Приложение описывается таблицей app_t; свои данные хранит в window_t.priv.

typedef struct window window_t;

enum { WM_MOVE, WM_DOWN, WM_UP, WM_WHEEL, WM_LEAVE };

typedef struct {
    int type;
    int x, y;        // относительно клиентской области окна
    int buttons;     // MB_*
    int dz;          // колесо
    int dbl;         // WM_DOWN: двойной клик
} wmouse_t;

typedef struct {
    // Рисует клиентскую область; (x, y) - её левый верхний угол на экране, отсечение уже настроено.
    void (*paint)(window_t *w, int x, int y, int cw, int ch);
    void (*key)(window_t *w, const key_event_t *k);
    void (*mouse)(window_t *w, const wmouse_t *m);
    void (*tick)(window_t *w, uint32_t now_ms);     // вызывается каждый проход главного цикла
    void (*close)(window_t *w);                     // окно закрывается, освободить priv
} app_t;

struct window {
    int used;
    int x, y, w, h;          // внешний прямоугольник
    int cw, ch;              // размер клиентской области
    char title[40];
    const app_t *app;
    void *priv;
};

void gui_init(void);
void gui_run(void) __attribute__((noreturn));

window_t *gui_create_window(const app_t *app, const char *title, int cw, int ch, void *priv);
void gui_close_window(window_t *w);
void gui_focus_window(window_t *w);
int  gui_is_focused(const window_t *w);
void gui_set_title(window_t *w, const char *title);

// Пометить область грязной (координаты экрана / относительные к клиентской области).
void gui_invalidate(int x, int y, int w, int h);
void gui_invalidate_window(window_t *w);
void gui_invalidate_client(window_t *w, int rx, int ry, int rw, int rh);

static inline int gui_client_x(const window_t *w) { return w->x + 1; }
static inline int gui_client_y(const window_t *w) { return w->y + 1 + 20; }   // 20 = TITLE_H

#endif
