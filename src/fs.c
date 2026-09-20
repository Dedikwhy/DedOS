#include "fs.h"
#include "string.h"
#include "version.h"

static file_t   ramdisk[MAX_FILES];
static file_t   root_node;
static uint32_t s_gen;

uint32_t fs_generation(void) { return s_gen; }

// ---------- пути ----------

const char *fs_basename(const char *abs) {
    const char *b = abs;
    for (const char *p = abs; *p; p++) if (*p == '/' && p[1]) b = p + 1;
    return b;
}

int fs_resolve(const char *cwd, const char *path, char *out) {
    char tmp[MAX_PATH];
    int len = 0;
    tmp[0] = '\0';

    const char *p = path;
    if (p[0] == '~' && (p[1] == '/' || p[1] == '\0')) {          // ~ = /home
        strlcpy(tmp, "/home", sizeof(tmp));
        len = 5;
        p++;
    } else if (p[0] != '/') {
        strlcpy(tmp, cwd, sizeof(tmp));
        len = (int)strlen(tmp);
        if (len == 1 && tmp[0] == '/') { tmp[0] = '\0'; len = 0; }
    }

    while (*p) {
        while (*p == '/') p++;
        if (!*p) break;
        char comp[MAX_FILENAME + 1];
        int cl = 0;
        while (*p && *p != '/') {
            if (cl >= MAX_FILENAME - 1) return -1;
            comp[cl++] = *p++;
        }
        comp[cl] = '\0';

        if (strcmp(comp, ".") == 0) continue;
        if (strcmp(comp, "..") == 0) {
            while (len > 0 && tmp[len - 1] != '/') len--;
            if (len > 0) len--;                                    // убрать сам '/'
            tmp[len] = '\0';
            continue;
        }
        if (len + 1 + cl >= MAX_PATH) return -1;
        tmp[len++] = '/';
        for (int i = 0; i < cl; i++) tmp[len++] = comp[i];
        tmp[len] = '\0';
    }

    if (len == 0) strlcpy(out, "/", MAX_PATH);
    else          strlcpy(out, tmp, MAX_PATH);
    return 0;
}

// "/a/b" -> parent="/a", name="b"; "/a" -> parent="/", name="a". Для "/" возвращает -1.
static int split(const char *abs, char *parent, char *name) {
    if (strcmp(abs, "/") == 0) return -1;
    const char *base = fs_basename(abs);
    if (strlen(base) >= MAX_FILENAME) return -1;
    strlcpy(name, base, MAX_FILENAME);
    size_t plen = (size_t)(base - abs);
    if (plen <= 1) strlcpy(parent, "/", MAX_PATH);
    else { memcpy(parent, abs, plen - 1); parent[plen - 1] = '\0'; }
    return 0;
}

static file_t *find(const char *parent, const char *name) {
    for (int i = 0; i < MAX_FILES; i++)
        if (ramdisk[i].used && strcmp(ramdisk[i].parent_path, parent) == 0 && strcmp(ramdisk[i].name, name) == 0)
            return &ramdisk[i];
    return 0;
}

file_t *fs_stat(const char *abs) {
    if (strcmp(abs, "/") == 0) return &root_node;
    char parent[MAX_PATH], name[MAX_FILENAME];
    if (split(abs, parent, name) < 0) return 0;
    return find(parent, name);
}

int fs_is_dir(const char *abs) {
    file_t *f = fs_stat(abs);
    return f && f->is_dir;
}

// ---------- изменение ----------

static int make_node(const char *abs, int is_dir) {
    char parent[MAX_PATH], name[MAX_FILENAME];
    if (split(abs, parent, name) < 0 || name[0] == '\0') return -3;
    if (!fs_is_dir(parent)) return -3;
    if (find(parent, name)) return -1;

    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used) continue;
        file_t *f = &ramdisk[i];
        memset(f, 0, sizeof(*f));
        strlcpy(f->name, name, MAX_FILENAME);
        strlcpy(f->parent_path, parent, MAX_PATH);
        f->is_dir = (uint8_t)is_dir;
        f->used = 1;
        s_gen++;
        return 0;
    }
    return -2;
}

int fs_create(const char *abs) { return make_node(abs, 0); }
int fs_mkdir(const char *abs)  { return make_node(abs, 1); }

int fs_write(const char *abs, const char *data, uint32_t len) {
    file_t *f = fs_stat(abs);
    if (!f || f->is_dir || f == &root_node) return -1;
    if (len >= MAX_FILE_SIZE) len = MAX_FILE_SIZE - 1;
    memcpy(f->data, data, len);
    f->data[len] = '\0';
    f->size = len;
    s_gen++;
    return (int)len;
}

int fs_remove(const char *abs) {
    if (strcmp(abs, "/") == 0) return -3;
    file_t *f = fs_stat(abs);
    if (!f) return -1;
    if (f->is_dir) {
        for (int i = 0; i < MAX_FILES; i++)
            if (ramdisk[i].used && strcmp(ramdisk[i].parent_path, abs) == 0) return -2;
    }
    f->used = 0;
    f->name[0] = '\0';
    f->data[0] = '\0';
    f->size = 0;
    s_gen++;
    return 0;
}

// ---------- чтение каталога ----------

// каталоги раньше файлов, дальше по алфавиту без учёта регистра
static int less(const file_t *a, const file_t *b) {
    if (a->is_dir != b->is_dir) return a->is_dir > b->is_dir;
    for (int i = 0; ; i++) {
        char x = a->name[i], y = b->name[i];
        if (x >= 'A' && x <= 'Z') x = (char)(x + 32);
        if (y >= 'A' && y <= 'Z') y = (char)(y + 32);
        if (x != y) return x < y;
        if (!x) return 0;
    }
}

int fs_readdir(const char *abs, file_t **out, int max) {
    if (!fs_is_dir(abs)) return -1;
    int n = 0;
    for (int i = 0; i < MAX_FILES && n < max; i++) {
        if (!ramdisk[i].used || strcmp(ramdisk[i].parent_path, abs) != 0) continue;
        file_t *f = &ramdisk[i];
        int j = n++;
        while (j > 0 && less(f, out[j - 1])) { out[j] = out[j - 1]; j--; }
        out[j] = f;
    }
    return n;
}

// ---------- стандартное дерево ----------

static void put(const char *path, const char *text) {
    fs_create(path);
    fs_write(path, text, (uint32_t)strlen(text));
}

void fs_init(void) {
    memset(ramdisk, 0, sizeof(ramdisk));
    memset(&root_node, 0, sizeof(root_node));
    root_node.used = 1;
    root_node.is_dir = 1;
    strlcpy(root_node.name, "/", MAX_FILENAME);

    fs_mkdir("/apps");
    fs_mkdir("/home");
    fs_mkdir("/system");
    fs_mkdir("/tmp");

    // .app - запускаемые приложения: файл хранит имя приложения
    put("/apps/terminal.app", "terminal");
    put("/apps/files.app",    "files");
    put("/apps/notepad.app",  "notepad");
    put("/apps/about.app",    "about");

    put("/home/readme.txt",
        "Welcome to DedOS " DEDOS_VERSION "!\n"
        "\n"
        "Super or Alt+F1 ... DedOS menu\n"
        "Alt+F2 ............ new Terminal\n"
        "Alt+F3 ............ Files\n"
        "Alt+Tab ........... next window\n"
        "Alt+F4 ............ close window\n"
        "\n"
        "Everything lives in RAM: files you create here\n"
        "are gone after a reboot.\n");
    put("/system/version", "DedOS " DEDOS_VERSION "\n");
    s_gen = 0;
}
