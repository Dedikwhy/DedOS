#include "vga.h"
#include "first_draw.h"
#include "terminal.h"

void kernel_main(void) {
    clear();

    disable_cursor();

    terminal();
}
