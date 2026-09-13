
#ifndef HOTKEYS_H
#define HOTKEYS_H

#include <stdint.h>

void hotkey_handle(uint8_t scancode);

int hotkey_is_ctrl_pressed(void);
int hotkey_is_alt_pressed(void);
int hotkey_is_shift_pressed(void);

int hotkey_is_russian(void);
void hotkey_set_russian(int enabled);
void hotkey_toggle_layout(void);

void hotkey_ctrl_c(void);
void hotkey_ctrl_v(void);
void hotkey_ctrl_l(void);

void hotkey_alt_f1(void);
void hotkey_alt_f2(void);

#endif