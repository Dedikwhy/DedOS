#ifndef FS_H
#define FS_H

#include <stdint.h>

#define MAX_FILES     64
#define MAX_FILENAME  32
#define MAX_FILE_SIZE 2048
#define MAX_PATH      64

typedef struct {
    char     name[MAX_FILENAME];
    char     data[MAX_FILE_SIZE];
    uint32_t size;
    int      used;
    uint8_t  is_dir;
    char     parent_path[MAX_PATH];   // путь каталога-родителя: "/", "/home", "/home/docs"
} file_t;

// Пути везде абсолютные и нормализованные ("/", "/home/a.txt", без хвостового '/').
// Относительные пути превращает в абсолютные fs_resolve().

void    fs_init(void);                                   // создаёт стандартное дерево
uint32_t fs_generation(void);                            // растёт при любом изменении (для обновления окон)

int     fs_resolve(const char *cwd, const char *path, char *out);   // 0 ок, -1 слишком длинный путь
file_t *fs_stat(const char *abs);                        // NULL, если нет; "/" - корневой каталог
int     fs_is_dir(const char *abs);

int     fs_create(const char *abs);                      // 0 ок, -1 есть, -2 нет места, -3 нет родителя/плохое имя
int     fs_mkdir(const char *abs);                       // те же коды
int     fs_write(const char *abs, const char *data, uint32_t len);   // записанные байты или -1
int     fs_remove(const char *abs);                      // файл или пустой каталог; -1 нет, -2 не пуст, -3 корень

// Содержимое каталога: сначала каталоги, потом файлы, по алфавиту. Возвращает число записей или -1.
int     fs_readdir(const char *abs, file_t **out, int max);

// Разбор пути: имя последнего компонента ("/a/b.txt" -> "b.txt").
const char *fs_basename(const char *abs);

#endif
