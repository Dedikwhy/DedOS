#ifndef GUI_H
#define GUI_H

// Инициализирует рабочий стол: фон, панель задач, окно терминала, мышь.
// Вызывается из kernel_main после успешного vbe_init().
void gui_init(void);

// Хуки, вызываемые из vga.c, когда активен GUI-режим:
// вывод текста идёт не в 0xB8000, а в окно терминала.
void gui_putchar(char c);
void gui_clear_terminal(void);
void gui_setcolor(unsigned char vga_attr);

// Вызывается драйвером мыши при каждом обновлении позиции/кнопок.
void gui_on_mouse_update(int x, int y, int left_button);

#endif
