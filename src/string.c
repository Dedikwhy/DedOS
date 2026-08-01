#include "string.h"

int strcmp(const char *s1, const char *s2) {
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    // Возвращает 0, если строки равны. 
    // Если не равны — вернет разницу ASCII-кодов первых не совпавших символов.
    return *(unsigned char *)s1 - *(unsigned char *)s2;
}

int strlen(const char *str) {
    int len = 0;
    while (str[len] != '\0') {
        len++;
    }
    return len;
}


int tokenize(char *buf, char **argv, int max_args) {
    int argc = 0;
    char *p = buf;

    while (*p && argc < max_args) {
        while (*p == ' ') p++;      // пропуск пробелов
        if (!*p) break;

        argv[argc++] = p;

        while (*p && *p != ' ') p++;
        if (*p) {
            *p = '\0';
            p++;
        }
    }

    return argc;
}