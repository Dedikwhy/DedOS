#include "fs.h"
#include "terminal.h"
#include "string.h"
#include <stddef.h>

static file_t ramdisk[MAX_FILES];

void fs_init(void) {
    for (int i = 0; i < MAX_FILES; i++) {
        ramdisk[i].used = 0;
        ramdisk[i].size = 0;
        ramdisk[i].is_dir = 0;
        ramdisk[i].name[0] = '\0';
        ramdisk[i].data[0] = '\0';
        ramdisk[i].parent_path[0] = '\0';
    }
}

void fs_list(void) {
    print("--- Filesystem (RAM) ---\n");
    int count = 0;

    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used) {
            print("  %s %s (%d bytes)\n", 
                  ramdisk[i].name, 
                  ramdisk[i].is_dir ? "[DIR]" : "", 
                  ramdisk[i].size);
            count++;
        }
    }

    if (count == 0) {
        print("  (empty)\n");
    }
}

int fs_create(const char *name) {
    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used && strcmp(ramdisk[i].name, name) == 0) {
            return -1;
        }
    }

    for (int i = 0; i < MAX_FILES; i++) {
        if (!ramdisk[i].used) {
            int j = 0;
            while (name[j] != '\0' && j < MAX_FILENAME - 1) {
                ramdisk[i].name[j] = name[j];
                j++;
            }
            ramdisk[i].name[j] = '\0';

            ramdisk[i].size = 0;
            ramdisk[i].data[0] = '\0';
            ramdisk[i].is_dir = 0;
            ramdisk[i].used = 1;
            return 0;
        }
    }

    return -2;
}

int fs_write(const char *name, const char *data, uint32_t len) {
    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used && strcmp(ramdisk[i].name, name) == 0) {
            uint32_t copy_len = len;
            if (copy_len >= MAX_FILE_SIZE) {
                copy_len = MAX_FILE_SIZE - 1;
            }

            for (uint32_t j = 0; j < copy_len; j++) {
                ramdisk[i].data[j] = data[j];
            }
            ramdisk[i].data[copy_len] = '\0';
            ramdisk[i].size = copy_len;
            return copy_len;
        }
    }
    return -1;
}

file_t* fs_get(const char *name) {
    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used && strcmp(ramdisk[i].name, name) == 0) {
            return &ramdisk[i];
        }
    }
    return 0;
}

int fs_remove(const char *filename) {
    if (filename == 0 || filename[0] == '\0') {
        return -1;
    }

    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used && strcmp(ramdisk[i].name, filename) == 0) {
            ramdisk[i].used = 0;         
            ramdisk[i].name[0] = '\0';   
            ramdisk[i].data[0] = '\0';   
            ramdisk[i].size = 0;         
            ramdisk[i].is_dir = 0;

            return 0;
        }
    }

    return -1;
}

int fs_mkdir(const char *dirname, const char *current_path) {
    if (dirname == 0 || dirname[0] == '\0') return -1;

    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used && 
            strcmp(ramdisk[i].parent_path, current_path) == 0 && 
            strcmp(ramdisk[i].name, dirname) == 0) {
            return -2;
        }
    }

    for (int i = 0; i < MAX_FILES; i++) {
        if (!ramdisk[i].used) {
            ramdisk[i].used = 1;
            ramdisk[i].is_dir = 1;
            ramdisk[i].size = 0;
            
            int j = 0;
            while (dirname[j] != '\0' && j < MAX_FILENAME - 1) {
                ramdisk[i].name[j] = dirname[j];
                j++;
            }
            ramdisk[i].name[j] = '\0';

            j = 0;
            while (current_path[j] != '\0' && j < 63) {
                ramdisk[i].parent_path[j] = current_path[j];
                j++;
            }
            ramdisk[i].parent_path[j] = '\0';

            return 0;
        }
    }
    return -1;
}

int fs_cd(const char *dirname, char *current_path) {
    if (strcmp(dirname, "/") == 0) {
        current_path[0] = '/';
        current_path[1] = '\0';
        return 0;
    }

    if (strcmp(dirname, "..") == 0) {
        if (strcmp(current_path, "/") == 0) return 0;
        
        int len = strlen(current_path);
        if (len > 1 && current_path[len - 1] == '/') {
            current_path[len - 1] = '\0';
            len--;
        }
        while (len > 0 && current_path[len - 1] != '/') {
            len--;
        }
        current_path[len] = '\0';
        return 0;
    }

    for (int i = 0; i < MAX_FILES; i++) {
        if (ramdisk[i].used && ramdisk[i].is_dir &&
            strcmp(ramdisk[i].parent_path, current_path) == 0 &&
            strcmp(ramdisk[i].name, dirname) == 0) {
            strcat(current_path, dirname);
            strcat(current_path, "/");
            return 0;
        }
    }

    return -1;
}