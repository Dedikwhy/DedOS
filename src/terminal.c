#include "terminal.h"
#include "first_draw.h"
#include "hell.h"
#include "fs.h"

#define MAX_ARGS 8

char cmd[64];
static int should_exit = 0;
char current_path[64] = "/";

static void cmd_help(int argc, char **argv) {
    (void)argc; (void)argv;
    print("Commands: \n");
    print("help\n");
    print("clear\n");
    print("version\n");
    print("echo <text>\n");
    print("ls\n");
    print("touch <file-name>\n");
    print("read <file-name>\n");
    print("write <file-name> <file-info>\n");
    print("rm <file-name>\n");
    print("mkdir <dir-name\n");
    print("cd <>\n");
    print("exit\n");
}

static void cmd_clear(int argc, char **argv) {
    (void)argc; (void)argv;
    clear();
    first_draw();
}

static void cmd_version(int argc, char **argv) {
    (void)argc; (void)argv;
    print("This version of DedOS = 0.2 here! :3\n");
    print("New: RAM File System\n");
    print("Echo\n");
    print("Parser.\n");
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
static void cmd_ls(int argc, char **argv) {
    (void)argc; (void)argv;
    fs_list();
}

static void cmd_touch(int argc, char **argv) {
    if (argc < 2) {
        print("Usage: touch <filename>\n");
        return;
    }
    int res = fs_create(argv[1]);
    if (res == 0) print("File created: %s\n", argv[1]);
    else if (res == -1) print("File already exists!\n");
    else print("Disk full!\n");
}

static void cmd_read(int argc, char **argv) {
    if (argc < 2) {
        print("Usage: cat <filename>\n");
        return;
    }
    file_t *file = fs_get(argv[1]);
    if (file) {
        print("%s\n", file->data);
    } else {
        print("File not found: %s\n", argv[1]);
    }
}

static void cmd_write(int argc, char **argv) {
    if (argc < 3) {
        print("Usage: write <filename> <text>\n");
        return;
    }
    
    char buffer[MAX_FILE_SIZE];
    int pos = 0;
    for (int i = 2; i < argc; i++) {
        int j = 0;
        while (argv[i][j] != '\0' && pos < MAX_FILE_SIZE - 2) {
            buffer[pos++] = argv[i][j++];
        }
        if (i + 1 < argc && pos < MAX_FILE_SIZE - 2) {
            buffer[pos++] = ' ';
        }
    }
    buffer[pos] = '\0';

    int res = fs_write(argv[1], buffer, pos);
    if (res >= 0) {
        print("Wrote %d bytes to %s\n", res, argv[1]);
    } else {
        print("File not found: %s\n", argv[1]);
    }
}
static void cmd_rm(int argc, char **argv) {
    if (argc < 2) {
        print("Usage: rm <filename>\n");
        return;
    }

    int res = fs_remove(argv[1]);
    if (res >= 0) {
        print("Deleted file: %s\n", argv[1]);
    } else {
        print("File not found: %s\n", argv[1]);
    }
}
static void cmd_mkdir(int argc, char **argv) {
    if (argc < 2) {
        print("Usage: mkdir <dirname>\n");
        return;
    }

    if (fs_mkdir(argv[1], current_path) == 0) {
        print("Directory created: %s\n", argv[1]);
    } else {
        print("Could not create directory\n");
    }
}
static void cmd_cd(int argc, char **argv) {
    if (argc < 2) {
        print("Current directory: %s\n", current_path);
        return;
    }

    if (fs_cd(argv[1], current_path) != 0) {
        print("No such directory: %s\n", argv[1]);
    }
}

static void cmd_pwd(int argc, char **argv) {
    (void)argc;
    (void)argv;
    print("%s\n", current_path);
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
    {"ls",      cmd_ls},
    {"touch",   cmd_touch},
    {"read",    cmd_read},
    {"write",   cmd_write},
    {"rm",      cmd_rm},
    {"mkdir",   cmd_mkdir},
    {"cd",      cmd_cd},
    {"pwd",     cmd_pwd},
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