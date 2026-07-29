CC = i386-elf-gcc
AS = i386-elf-as
LD = i386-elf-ld

CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra -Iinclude
ASFLAGS = --32

# Список всех C-файлов
C_SOURCES = $(wildcard src/*.c)
# Преобразуем src/foo.c в build/foo.o
OBJS = build/boot.o $(patsubst src/%.c, build/%.o, $(C_SOURCES))

QEMU = "/c/Program Files/qemu/qemu-system-i386.exe"

all: build/myos.bin

# Сборка ассемблерного загрузчика
build/boot.o: src/boot.s | build
	$(AS) $(ASFLAGS) $< -o $@

# Компиляция C-файлов напрямую в .o (без промежуточных .s файлов)
build/%.o: src/%.c | build
	$(CC) -c $< -o $@ $(CFLAGS)

# Линковка готового бинарника
build/myos.bin: $(OBJS)
	$(LD) -T linker.ld -o $@ $(OBJS)

# Создание папки build если её нет
build:
	mkdir -p build

# Запуск в QEMU
run: build/myos.bin
	$(QEMU) -kernel build/myos.bin

# Очистка проекта
clean:
	rm -rf build