#ifndef MOUSE_H
#define MOUSE_H

#include <stdint.h>

// Инициализирует PS/2 мышь (контроллер 8042, aux-порт).
void mouse_init(void);

// Проверяет порт данных и, если пришёл байт от мыши, обновляет состояние.
// Нужно вызывать часто (например, в цикле ожидания клавиатуры).
void mouse_poll(void);

int mouse_get_x(void);
int mouse_get_y(void);
int mouse_get_left_button(void);

#endif
