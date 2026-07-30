#include "terminal.h"
#include "first_draw.h"
#include "hell.h"

char cmd[64];

void terminal() {
    first_draw();

    while (1)
    {
        print("user> ");
        scan(cmd, 64);

        if (strcmp(cmd, "help") == 0){
            print("Commands: \n");
            print("Help\n");
            print("Clear\n");
            print("Version\n");
            print("Exit\n");
        }
        else if (strcmp(cmd, "clear") == 0){
            clear();
            first_draw();
        }
        else if (strcmp(cmd, "version") == 0){
            print("This version of DedOS = 0.1 :3\n");
        }
        else if (strcmp(cmd, "exit") == 0){
            break;
        }
        else if (strcmp(cmd, "hell") == 0)
        {
            M_Hell();
        }
        
        else{
            print("Unknown command\n");
        }
        
        
    }
    
}