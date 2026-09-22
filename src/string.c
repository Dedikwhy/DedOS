#include "string.h"

int strcmp(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *(const unsigned char *)a - *(const unsigned char *)b;
}

int strncmp(const char *a, const char *b, size_t n) {
    for (; n; n--, a++, b++) {
        if (*a != *b) return *(const unsigned char *)a - *(const unsigned char *)b;
        if (!*a) return 0;
    }
    return 0;
}

size_t strlen(const char *s) {
    size_t n = 0;
    while (s[n]) n++;
    return n;
}

char *strcat(char *dst, const char *src) {
    char *p = dst + strlen(dst);
    while ((*p++ = *src++)) {}
    return dst;
}

char *strlcpy(char *dst, const char *src, size_t n) {
    if (n == 0) return dst;
    size_t i = 0;
    for (; i + 1 < n && src[i]; i++) dst[i] = src[i];
    dst[i] = '\0';
    return dst;
}

int str_ends_with(const char *s, const char *suffix) {
    size_t a = strlen(s), b = strlen(suffix);
    return a >= b && strcmp(s + a - b, suffix) == 0;
}

// memcpy/memset нужны самому gcc (структуры, инициализация массивов).
void *memcpy(void *dst, const void *src, size_t n) {
    void *ret = dst;
    __asm__ volatile ("rep movsb" : "+D"(dst), "+S"(src), "+c"(n) : : "memory");
    return ret;
}

void *memmove(void *dst, const void *src, size_t n) {
    unsigned char *d = dst;
    const unsigned char *s = src;
    if (d < s) {
        while (n--) *d++ = *s++;
    } else {
        d += n; s += n;
        while (n--) *--d = *--s;
    }
    return dst;
}

void *memset(void *dst, int c, size_t n) {
    void *ret = dst;
    __asm__ volatile ("rep stosb" : "+D"(dst), "+c"(n) : "a"(c) : "memory");
    return ret;
}

int tokenize(char *buf, char **argv, int max_args) {
    int argc = 0;
    char *p = buf;
    while (*p && argc < max_args) {
        while (*p == ' ') p++;
        if (!*p) break;
        argv[argc++] = p;
        while (*p && *p != ' ') p++;
        if (*p) *p++ = '\0';
    }
    return argc;
}

// ---------- ksnprintf ----------

typedef struct { char *buf; size_t n, len; } out_t;

static void out_ch(out_t *o, char c) {
    if (o->len + 1 < o->n) o->buf[o->len] = c;
    o->len++;
}

static void out_pad(out_t *o, int count, char c) {
    while (count-- > 0) out_ch(o, c);
}

static void out_num(out_t *o, unsigned int v, int base, int neg, int width, int left, char pad) {
    char tmp[16];
    int n = 0;
    const char *digits = "0123456789abcdef";
    do { tmp[n++] = digits[v % base]; v /= base; } while (v);
    int total = n + (neg ? 1 : 0);
    if (!left && pad == ' ') out_pad(o, width - total, ' ');
    if (neg) out_ch(o, '-');
    if (!left && pad == '0') out_pad(o, width - total, '0');
    while (n) out_ch(o, tmp[--n]);
    if (left) out_pad(o, width - total, ' ');
}

int kvsnprintf(char *buf, size_t n, const char *fmt, va_list ap) {
    out_t o = { buf, n, 0 };
    for (; *fmt; fmt++) {
        if (*fmt != '%') { out_ch(&o, *fmt); continue; }
        fmt++;
        int left = 0, width = 0;
        char pad = ' ';
        for (;; fmt++) {
            if (*fmt == '-') left = 1;
            else if (*fmt == '0') pad = '0';
            else break;
        }
        while (*fmt >= '0' && *fmt <= '9') width = width * 10 + (*fmt++ - '0');
        switch (*fmt) {
        case 's': {
            const char *s = va_arg(ap, const char *);
            if (!s) s = "(null)";
            int l = (int)strlen(s);
            if (!left) out_pad(&o, width - l, ' ');
            while (*s) out_ch(&o, *s++);
            if (left) out_pad(&o, width - l, ' ');
            break;
        }
        case 'c': out_ch(&o, (char)va_arg(ap, int)); break;
        case 'd': {
            int v = va_arg(ap, int);
            out_num(&o, v < 0 ? 0u - (unsigned int)v : (unsigned int)v, 10, v < 0, width, left, pad);
            break;
        }
        case 'u': out_num(&o, va_arg(ap, unsigned int), 10, 0, width, left, pad); break;
        case 'x': out_num(&o, va_arg(ap, unsigned int), 16, 0, width, left, pad); break;
        case '%': out_ch(&o, '%'); break;
        case '\0': fmt--; break;
        default:  out_ch(&o, '%'); out_ch(&o, *fmt); break;
        }
    }
    if (n) buf[o.len < n ? o.len : n - 1] = '\0';
    return (int)o.len;
}

int ksnprintf(char *buf, size_t n, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = kvsnprintf(buf, n, fmt, ap);
    va_end(ap);
    return r;
}
