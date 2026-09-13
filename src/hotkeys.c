
#include "hotkeys.h"

static int ctrl_pressed = 0;
static int alt_pressed = 0;
static int shift_pressed = 0;
static int rus_layout = 0;
static int layout_combo_used = 0;

void hotkey_handle(uint8_t scancode)
{
    if (scancode == 0x1D) {
        ctrl_pressed = 1;
        return;
    }

    if (scancode == 0x9D) {
        ctrl_pressed = 0;
        return;
    }

    if (scancode == 0x38) {
        alt_pressed = 1;
        return;
    }

    if (scancode == 0xB8) {
        alt_pressed = 0;
        layout_combo_used = 0;
        return;
    }

    if (scancode == 0x2A || scancode == 0x36) {
        if (alt_pressed && !layout_combo_used) {
            hotkey_toggle_layout();
            layout_combo_used = 1;
        }

        shift_pressed = 1;
        return;
    }

    if (scancode == 0xAA || scancode == 0xB6) {
        shift_pressed = 0;
        layout_combo_used = 0;
        return;
    }

    if (ctrl_pressed) {
        if (scancode == 0x2E) {
            hotkey_ctrl_c();
            return;
        }

        if (scancode == 0x2F) {
            hotkey_ctrl_v();
            return;
        }

        if (scancode == 0x26) {
            hotkey_ctrl_l();
            return;
        }
    }

    if (alt_pressed) {
        if (scancode == 0x3B) {
            hotkey_alt_f1();
            return;
        }

        if (scancode == 0x3C) {
            hotkey_alt_f2();
            return;
        }
    }
}

int hotkey_is_russian(void)
{
    return rus_layout;
}

void hotkey_set_russian(int enabled)
{
    rus_layout = enabled ? 1 : 0;
}

void hotkey_toggle_layout(void)
{
    rus_layout = !rus_layout;
}

int hotkey_is_ctrl_pressed(void)
{
    return ctrl_pressed;
}

int hotkey_is_alt_pressed(void)
{
    return alt_pressed;
}

int hotkey_is_shift_pressed(void)
{
    return shift_pressed;
}

void hotkey_ctrl_c(void)
{
}

void hotkey_ctrl_v(void)
{
}

void hotkey_ctrl_l(void)
{
}

void hotkey_alt_f1(void)
{
}

void hotkey_alt_f2(void)
{
}