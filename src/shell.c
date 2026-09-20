#include "shell.h"
#include "apps.h"
#include "string.h"
#include "timer.h"
#include "version.h"

#define MAX_ARGS 24

void sh_print(shell_t *sh, int attr, const char *fmt, ...) {
    char buf[256];
    va_list ap;
    va_start(ap, fmt);
    kvsnprintf(buf, sizeof(buf), fmt, ap);
    va_end(ap);
    sh->io->out(sh->ctx, buf, attr);
}

static void err(shell_t *sh, const char *cmd, const char *what, const char *arg) {
    if (arg) sh_print(sh, SA_ERROR, "%s: %s: %s\n", cmd, arg, what);
    else     sh_print(sh, SA_ERROR, "%s: %s\n", cmd, what);
}

// argv[i] относительно cwd -> абсолютный путь
static int path_of(shell_t *sh, const char *cmd, const char *arg, char *out) {
    if (fs_resolve(sh->cwd, arg, out) < 0) { err(sh, cmd, "path too long", arg); return -1; }
    return 0;
}

// ---------- команды ----------

typedef struct {
    const char *name;
    const char *usage;
    const char *help;
    void (*fn)(shell_t *sh, int argc, char **argv);
} command_t;

static const command_t COMMANDS[];

static void cmd_help(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    for (const command_t *c = COMMANDS; c->name; c++)
        if (c->usage) sh_print(sh, SA_NORMAL, "  %-20s %s\n", c->usage, c->help);
}

static void cmd_clear(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    sh->io->clear(sh->ctx);
}

static void cmd_version(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    sh_print(sh, SA_ACCENT, "DedOS %s\n", DEDOS_VERSION);
    sh_print(sh, SA_DIM, "x86, Ring 0, VBE framebuffer desktop, RAM filesystem\n");
}

static void cmd_echo(shell_t *sh, int argc, char **argv) {
    for (int i = 1; i < argc; i++) {
        sh_print(sh, SA_NORMAL, "%s%s", argv[i], i + 1 < argc ? " " : "");
    }
    sh_print(sh, SA_NORMAL, "\n");
}

static void cmd_pwd(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    sh_print(sh, SA_NORMAL, "%s\n", sh->cwd);
}

static void cmd_cd(shell_t *sh, int argc, char **argv) {
    char abs[MAX_PATH];
    if (path_of(sh, "cd", argc < 2 ? "~" : argv[1], abs) < 0) return;
    file_t *f = fs_stat(abs);
    if (!f) { err(sh, "cd", "no such directory", argv[argc < 2 ? 0 : 1]); return; }
    if (!f->is_dir) { err(sh, "cd", "not a directory", argv[1]); return; }
    strlcpy(sh->cwd, abs, sizeof(sh->cwd));
}

static void cmd_ls(shell_t *sh, int argc, char **argv) {
    int longfmt = 0;
    const char *target = ".";
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-l") == 0) longfmt = 1;
        else target = argv[i];
    }
    char abs[MAX_PATH];
    if (path_of(sh, "ls", target, abs) < 0) return;

    file_t *f = fs_stat(abs);
    if (!f) { err(sh, "ls", "no such file or directory", target); return; }
    if (!f->is_dir) { sh_print(sh, SA_NORMAL, "%s\n", target); return; }

    file_t *list[MAX_FILES];
    int n = fs_readdir(abs, list, MAX_FILES);
    if (n == 0) { sh_print(sh, SA_DIM, "(empty)\n"); return; }

    int col = 0;
    for (int i = 0; i < n; i++) {
        if (longfmt) {
            if (list[i]->is_dir) sh_print(sh, SA_DIR, "d %6s  %s/\n", "-", list[i]->name);
            else                 sh_print(sh, SA_NORMAL, "- %6u  %s\n", list[i]->size, list[i]->name);
            continue;
        }
        int len = (int)strlen(list[i]->name) + (list[i]->is_dir ? 1 : 0);
        if (col && col + len + 2 > sh->cols) { sh_print(sh, SA_NORMAL, "\n"); col = 0; }
        sh_print(sh, list[i]->is_dir ? SA_DIR : SA_NORMAL, "%s%s  ", list[i]->name, list[i]->is_dir ? "/" : "");
        col += len + 2;
    }
    if (!longfmt) sh_print(sh, SA_NORMAL, "\n");
}

static void cmd_cat(shell_t *sh, int argc, char **argv) {
    if (argc < 2) { err(sh, argv[0], "usage: cat <file>", 0); return; }
    char abs[MAX_PATH];
    if (path_of(sh, "cat", argv[1], abs) < 0) return;
    file_t *f = fs_stat(abs);
    if (!f) { err(sh, "cat", "no such file", argv[1]); return; }
    if (f->is_dir) { err(sh, "cat", "is a directory", argv[1]); return; }
    sh_print(sh, SA_NORMAL, "%s", f->data);
    if (f->size && f->data[f->size - 1] != '\n') sh_print(sh, SA_NORMAL, "\n");
}

static void cmd_touch(shell_t *sh, int argc, char **argv) {
    if (argc < 2) { err(sh, "touch", "usage: touch <file>", 0); return; }
    char abs[MAX_PATH];
    if (path_of(sh, "touch", argv[1], abs) < 0) return;
    switch (fs_create(abs)) {
    case 0:  break;
    case -1: err(sh, "touch", "already exists", argv[1]); break;
    case -2: err(sh, "touch", "filesystem full", 0); break;
    default: err(sh, "touch", "cannot create (no such directory?)", argv[1]); break;
    }
}

static void cmd_mkdir(shell_t *sh, int argc, char **argv) {
    if (argc < 2) { err(sh, "mkdir", "usage: mkdir <dir>", 0); return; }
    char abs[MAX_PATH];
    if (path_of(sh, "mkdir", argv[1], abs) < 0) return;
    switch (fs_mkdir(abs)) {
    case 0:  break;
    case -1: err(sh, "mkdir", "already exists", argv[1]); break;
    case -2: err(sh, "mkdir", "filesystem full", 0); break;
    default: err(sh, "mkdir", "cannot create (no such directory?)", argv[1]); break;
    }
}

static void cmd_write(shell_t *sh, int argc, char **argv) {
    if (argc < 3) { err(sh, "write", "usage: write <file> <text...>", 0); return; }
    char abs[MAX_PATH];
    if (path_of(sh, "write", argv[1], abs) < 0) return;

    char buf[MAX_FILE_SIZE];
    int pos = 0;
    for (int i = 2; i < argc; i++) {
        for (int j = 0; argv[i][j] && pos < MAX_FILE_SIZE - 2; j++) buf[pos++] = argv[i][j];
        if (i + 1 < argc && pos < MAX_FILE_SIZE - 2) buf[pos++] = ' ';
    }
    buf[pos++] = '\n';
    buf[pos] = '\0';

    if (!fs_stat(abs)) {
        int r = fs_create(abs);
        if (r == -2) { err(sh, "write", "filesystem full", 0); return; }
        if (r < 0)   { err(sh, "write", "cannot create (no such directory?)", argv[1]); return; }
    }
    if (fs_write(abs, buf, (uint32_t)pos) < 0) err(sh, "write", "not a file", argv[1]);
}

static void cmd_rm(shell_t *sh, int argc, char **argv) {
    if (argc < 2) { err(sh, "rm", "usage: rm <path>", 0); return; }
    char abs[MAX_PATH];
    if (path_of(sh, "rm", argv[1], abs) < 0) return;
    switch (fs_remove(abs)) {
    case 0:  break;
    case -2: err(sh, "rm", "directory not empty", argv[1]); break;
    case -3: err(sh, "rm", "cannot remove /", 0); break;
    default: err(sh, "rm", "no such file or directory", argv[1]); break;
    }
    // если удалили каталог, в котором стоим
    if (!fs_is_dir(sh->cwd)) strlcpy(sh->cwd, "/", sizeof(sh->cwd));
}

static void cmd_open(shell_t *sh, int argc, char **argv) {
    if (argc < 2) { err(sh, "open", "usage: open <path>", 0); return; }
    char abs[MAX_PATH];
    if (path_of(sh, "open", argv[1], abs) < 0) return;
    if (app_open_path(abs) < 0) err(sh, "open", "no such file or directory", argv[1]);
}

static void cmd_files(shell_t *sh, int argc, char **argv) {
    char abs[MAX_PATH];
    if (argc < 2) { app_files_open(sh->cwd); return; }
    if (path_of(sh, "files", argv[1], abs) < 0) return;
    if (!fs_is_dir(abs)) { err(sh, "files", "not a directory", argv[1]); return; }
    app_files_open(abs);
}

static void cmd_notepad(shell_t *sh, int argc, char **argv) {
    char abs[MAX_PATH];
    if (argc < 2) { app_notepad_open(0); return; }
    if (path_of(sh, "notepad", argv[1], abs) < 0) return;
    if (fs_is_dir(abs)) { err(sh, "notepad", "is a directory", argv[1]); return; }
    app_notepad_open(abs);
}

static void cmd_terminal(shell_t *sh, int argc, char **argv) { (void)sh; (void)argc; (void)argv; app_terminal_open(); }
static void cmd_about(shell_t *sh, int argc, char **argv)    { (void)sh; (void)argc; (void)argv; app_about_open(); }

static void cmd_date(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    rtc_time_t t;
    rtc_get(&t);
    sh_print(sh, SA_NORMAL, "%04d-%02d-%02d %02d:%02d:%02d\n", t.year, t.month, t.day, t.hour, t.minute, t.second);
}

static void cmd_uptime(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    uint32_t s = timer_ms() / 1000;
    sh_print(sh, SA_NORMAL, "up %dh %02dm %02ds\n", (int)(s / 3600), (int)(s / 60 % 60), (int)(s % 60));
}

static void cmd_hell(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    for (int r = 0; r < 10; r++) {
        for (int c = 0; c < sh->cols / 5; c++) sh_print(sh, SA_ERROR, "HELL ");
        sh_print(sh, SA_ERROR, "\n");
    }
    sh_print(sh, SA_DIM, "...okay, back to work.\n");
}

static void cmd_exit(shell_t *sh, int argc, char **argv) {
    (void)argc; (void)argv;
    sh->io->exit(sh->ctx);
}

static const command_t COMMANDS[] = {
    { "help",     "help",              "list commands",                 cmd_help },
    { "ls",       "ls [-l] [path]",    "list directory",                cmd_ls },
    { "cd",       "cd [path]",         "change directory (~ = /home)",  cmd_cd },
    { "pwd",      "pwd",               "print working directory",       cmd_pwd },
    { "cat",      "cat <file>",        "print file (also: read)",       cmd_cat },
    { "read",     0,                   0,                               cmd_cat },
    { "touch",    "touch <file>",      "create empty file",             cmd_touch },
    { "mkdir",    "mkdir <dir>",       "create directory",              cmd_mkdir },
    { "write",    "write <file> <txt>","replace file contents",         cmd_write },
    { "rm",       "rm <path>",         "remove file or empty dir",      cmd_rm },
    { "echo",     "echo <text>",       "print text",                    cmd_echo },
    { "open",     "open <path>",       "open in Files / Notepad / app", cmd_open },
    { "files",    "files [path]",      "open Files",                    cmd_files },
    { "notepad",  "notepad [file]",    "open Notepad (also: edit)",     cmd_notepad },
    { "edit",     0,                   0,                               cmd_notepad },
    { "terminal", "terminal",          "open another Terminal",         cmd_terminal },
    { "about",    "about",             "about DedOS",                   cmd_about },
    { "version",  "version",           "print version",                 cmd_version },
    { "date",     "date",              "current date and time",         cmd_date },
    { "uptime",   "uptime",            "time since boot",               cmd_uptime },
    { "clear",    "clear",             "clear the screen (Ctrl+L)",     cmd_clear },
    { "hell",     0,                   0,                               cmd_hell },
    { "exit",     "exit",              "close this Terminal",           cmd_exit },
    { 0, 0, 0, 0 }
};

void shell_init(shell_t *sh, const shell_io_t *io, void *ctx, int cols) {
    sh->io = io;
    sh->ctx = ctx;
    sh->cols = cols;
    strlcpy(sh->cwd, "/home", sizeof(sh->cwd));
}

void shell_exec(shell_t *sh, char *line) {
    char *argv[MAX_ARGS];
    int argc = tokenize(line, argv, MAX_ARGS);
    if (argc == 0) return;

    for (const command_t *c = COMMANDS; c->name; c++) {
        if (strcmp(argv[0], c->name) == 0) { c->fn(sh, argc, argv); return; }
    }
    sh_print(sh, SA_ERROR, "%s: command not found (try 'help')\n", argv[0]);
}

void shell_prompt(const shell_t *sh, char *buf, int n) {
    char shown[MAX_PATH + 2];
    if (strcmp(sh->cwd, "/home") == 0) strlcpy(shown, "~", sizeof(shown));
    else if (strncmp(sh->cwd, "/home/", 6) == 0) { shown[0] = '~'; strlcpy(shown + 1, sh->cwd + 5, sizeof(shown) - 1); }
    else strlcpy(shown, sh->cwd, sizeof(shown));
    ksnprintf(buf, (size_t)n, "ded@dedos:%s$ ", shown);
}
