#include "hell.h"

char hell_mode[4];

void M_Hell() {
        setcolor(VGA_COLOR(VGA_COLOR_WHITE, VGA_COLOR_LIGHT_RED));
        while(1) {
            print("HELL");
        }
    }