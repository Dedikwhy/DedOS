#ifndef FS_H
#define FS_H

#include <stdint.h>

#define MAX_FILES 16
#define MAX_FILENAME 32
#define MAX_FILE_SIZE 1024


typedef struct {
    char name[MAX_FILENAME];
    char data[MAX_FILE_SIZE];
    uint32_t size;
    int used;
    uint8_t is_dir;
    char parent_path[64];
} file_t;


void fs_init(void);
int fs_create(const char *name, const char *current_path);
int fs_write(const char *name, const char *data, uint32_t len);
file_t* fs_get(const char *name);
void fs_list(const char *current_path);
int fs_remove(const char *filename);
int fs_mkdir(const char *dirname, const char *current_path);
int fs_cd(const char *dirname, char *current_path);

#endif