#include "vga.h"
#include "vbe.h"
#include "gfx.h"
#include "gui.h"
#include "fs.h"
#include "timer.h"
#include "keyboard.h"
#include "mouse.h"

#define SCREEN_W 1024
#define SCREEN_H 768

static void no_video(const char *why) {
    clear();
    disable_cursor();
    setcolor(VGA_COLOR(VGA_COLOR_LIGHT_RED, VGA_COLOR_BLACK));
    print("DedOS: %s\n\n", why);
    setcolor(VGA_COLOR(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK));
    print("The desktop needs a Bochs/QEMU VBE display (qemu -vga std).\n");
    for (;;) __asm__ volatile ("cli; hlt");
}

void kernel_main(void) {
    if (!vbe_init(SCREEN_W, SCREEN_H, 32)) no_video("no VBE framebuffer found");

    const vbe_info_t *v = vbe_get_info();
    if (!gfx_init(v->fb, v->width, v->height, v->pitch)) no_video("unsupported resolution");

    timer_init();
    fs_init();
    kbd_init();
    mouse_init((int)v->width, (int)v->height);
    gui_init();
    gui_run();
}
