#ifndef MOUSE_H
#define MOUSE_H

#include <stdint.h>

#define MB_LEFT   1
#define MB_RIGHT  2
#define MB_MIDDLE 4

typedef struct {
    int x, y;          // экранные координаты после движения
    int buttons;       // MB_*
    int dz;            // колесо: >0 вверх, <0 вниз
} mouse_event_t;

// PS/2 мышь (8042 aux). Включает колесо (IntelliMouse), если оно есть.
void mouse_init(int screen_w, int screen_h);
void mouse_feed(uint8_t byte);           // байт из порта 0x60 с флагом AUX
int  mouse_pop(mouse_event_t *ev);       // 1, если событие есть
int  mouse_x(void);
int  mouse_y(void);

#endif
