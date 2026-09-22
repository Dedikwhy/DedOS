# DedOS

Маленькая экспериментальная ОС: x86, Multiboot (GRUB / `qemu -kernel`), всё в Ring 0.
Фреймбуфер VBE (Bochs/QEMU std VGA) 1024x768x32, свой рабочий стол, PS/2 клавиатура и мышь, RAM-файловая система.

## Сборка и запуск

    make run        # собрать и запустить в QEMU (-kernel)
    make iso        # собрать DedOS.iso (нужны grub-mkrescue + xorriso)
    make run-iso    # ISO в QEMU

Тулчейн Makefile выбирает сам: WSL-кросс `/mnt/c/i868-elf` -> `i686-elf-gcc` -> `gcc -m32`.
Нужен `nasm`. Видеокарта должна быть `-vga std` (по умолчанию в QEMU).

## Управление

| Клавиши            | Действие                        |
|--------------------|---------------------------------|
| Super / Alt+F1     | меню DedOS                      |
| Alt+F2, Ctrl+Alt+T | новый терминал                  |
| Alt+F3             | файловый менеджер               |
| Alt+Tab            | переключить окно                |
| Alt+Shift+Tab      | окно на задний план             |
| Alt+1..9           | фокус на окно N                 |
| Alt+F4             | закрыть окно                    |
| Alt+C              | центрировать окно               |
| Ctrl+Alt+T/F/N     | Terminal / Files / Notepad      |
| Ctrl+Alt+стрелки   | двигать окно                    |
| ПКМ                | контекстное меню (рабочий стол, окно, приложения) |

Terminal: стрелки, история, Ctrl+C/L/U/V, PgUp/PgDn, колесо мыши.
Notepad: Ctrl+S сохранить, Ctrl+C/X/V — копировать/вырезать строку/вставить.

## Структура

    boot.asm          Multiboot-заголовок, стек
    src/kernel.c      точка входа
    src/vbe.c gfx.c   видеорежим, рисование (back buffer + грязные прямоугольники)
    src/gui.c         рабочий стол, окна, панель, меню, фокус, события
    src/icons.c       иконки (рисуются прямоугольниками)
    src/apps.c        список приложений, открытие путей
    src/app_*.c       Terminal, Files, Notepad, About
    src/shell.c       команды shell
    src/fs.c          RAM-ФС
    src/keyboard.c mouse.c input.c timer.c   ввод, PIT/RTC
    src/vga.c         текстовый режим (только сообщение об ошибке без VBE)
