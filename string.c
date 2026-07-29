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