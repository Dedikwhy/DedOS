#ifndef STRING_H
#define STRING_H

#include <stddef.h>
#include <stdarg.h>

int    strcmp(const char *a, const char *b);
int    strncmp(const char *a, const char *b, size_t n);
size_t strlen(const char *s);
char  *strcat(char *dst, const char *src);
// Копирует не больше n-1 символов, всегда ставит '\0'. Возвращает dst.
char  *strlcpy(char *dst, const char *src, size_t n);
int    str_ends_with(const char *s, const char *suffix);

void  *memcpy(void *dst, const void *src, size_t n);
void  *memmove(void *dst, const void *src, size_t n);
void  *memset(void *dst, int c, size_t n);

// Режет строку по пробелам на месте, возвращает argc.
int tokenize(char *buf, char **argv, int max_args);

// Мини-printf: %s %c %d %u %x %% + флаги '-' и '0', ширина. Возвращает длину результата.
int ksnprintf(char *buf, size_t n, const char *fmt, ...);
int kvsnprintf(char *buf, size_t n, const char *fmt, va_list ap);

#endif
