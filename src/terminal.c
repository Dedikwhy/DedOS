#include "terminal.h"
#include "first_draw.h"
#include "hell.h"

#define MAX_ARGS 8

char cmd[64];
static int should_exit = 0;

static void cmd_help(int argc, char **argv) {
    (void)argc; (void)argv;
    print("Commands: \n");
    print("help\n");
    print("clear\n");
    print("version\n");
    print("echo <text>\n");
    print("exit\n");
}

static void cmd_clear(int argc, char **argv) {
    (void)argc; (void)argv;
    clear();
    first_draw();
}

static void cmd_version(int argc, char **argv) {
    (void)argc; (void)argv;
    print("This version of DedOS = 0.1 :3\n");
}

static void cmd_exit(int argc, char **argv) {
    (void)argc; (void)argv;
    should_exit = 1;
}

static void cmd_hell(int argc, char **argv) {
    (void)argc; (void)argv;
    M_Hell();
}

static void cmd_echo(int argc, char **argv) {
    for (int i = 1; i < argc; i++) {
        print("%s", argv[i]);
        if (i + 1 < argc) print(" ");
    }
    print("\n");
}

typedef struct {
    const char *name;
    void (*handler)(int argc, char **argv);
} command_t;

static const command_t commands[] = {
    {"help",    cmd_help},
    {"clear",   cmd_clear},
    {"version", cmd_version},
    {"exit",    cmd_exit},
    {"hell",    cmd_hell},
    {"echo",    cmd_echo},
};

#define NUM_COMMANDS (sizeof(commands) / sizeof(commands[0]))

static void dispatch(int argc, char **argv) {
    if (argc == 0) return;

    for (unsigned int i = 0; i < NUM_COMMANDS; i++) {
        if (strcmp(argv[0], commands[i].name) == 0) {
            commands[i].handler(argc, argv);
            return;
        }
    }

    print("Unknown command: %s\n", argv[0]);
}

void terminal() {
    first_draw();

    while (!should_exit)
    {
        char *argv[MAX_ARGS];

        print("user> ");
        scan(cmd, 64);

        int argc = tokenize(cmd, argv, MAX_ARGS);
        dispatch(argc, argv);
    }
}