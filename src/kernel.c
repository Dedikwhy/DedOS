#include "vga.h"
#include "first_draw.h"
#include "terminal.h"
#include "vbe.h"
#include "gui.h"

void kernel_main(void) {
    // Пробуем включить графический режим (VBE через QEMU/Bochs dispi).
    // Если видеокарта не поддерживает его, остаёмся в обычном текстовом режиме.
    if (vbe_init(1024, 768, 32)) {
        vga_set_gui_mode(1);
        gui_init();
    } else {
        clear();
        disable_cursor();
    }

    terminal();
}
