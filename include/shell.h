#ifndef SHELL_H
#define SHELL_H

#include "fs.h"

// Shell не знает, куда выводит текст: терминал даёт ему три колбэка.

enum { SA_NORMAL, SA_DIM, SA_ACCENT, SA_ERROR, SA_DIR };   // «цвет» вывода

typedef struct {
    void (*out)(void *ctx, const char *s, int attr);
    void (*clear)(void *ctx);
    void (*exit)(void *ctx);
} shell_io_t;

typedef struct {
    const shell_io_t *io;
    void *ctx;
    int   cols;                 // ширина терминала (для ls)
    char  cwd[MAX_PATH];
} shell_t;

void shell_init(shell_t *sh, const shell_io_t *io, void *ctx, int cols);
void shell_exec(shell_t *sh, char *line);                 // line портится (режется на токены)
void shell_prompt(const shell_t *sh, char *buf, int n);   // "ded@dedos:~$ "
void sh_print(shell_t *sh, int attr, const char *fmt, ...);

#endif
