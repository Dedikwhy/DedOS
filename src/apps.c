#include "apps.h"
#include "fs.h"
#include "string.h"
#include "icons.h"

static window_t *open_files(void)   { return app_files_open(0); }
static window_t *open_notepad(void) { return app_notepad_open(0); }

const app_entry_t APP_LIST[] = {
    { "terminal", "Terminal", ICON_TERMINAL, app_terminal_open },
    { "files",    "Files",    ICON_FILES,    open_files },
    { "notepad",  "Notepad",  ICON_NOTEPAD,  open_notepad },
    { "about",    "About",    ICON_ABOUT,    app_about_open },
};
const int APP_COUNT = sizeof(APP_LIST) / sizeof(APP_LIST[0]);

window_t *app_launch(const char *name) {
    for (int i = 0; i < APP_COUNT; i++)
        if (strcmp(APP_LIST[i].name, name) == 0) return APP_LIST[i].open();
    return 0;
}

int app_open_path(const char *abs) {
    file_t *f = fs_stat(abs);
    if (!f) return -1;
    if (f->is_dir) { app_files_open(abs); return 0; }
    if (str_ends_with(abs, ".app")) {
        char name[MAX_FILENAME];
        strlcpy(name, f->data, sizeof(name));
        size_t n = strlen(name);
        while (n && (name[n - 1] == '\n' || name[n - 1] == ' ')) name[--n] = '\0';
        if (!app_launch(name)) return -1;
        return 0;
    }
    app_notepad_open(abs);
    return 0;
}
