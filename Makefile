CC = /mnt/c/i868-elf/i386-elf-gcc/bin/i386-elf-gcc.exe
AS = /mnt/c/i868-elf/i386-elf-binutils/bin/i386-elf-as.exe
LD = /mnt/c/i868-elf/i386-elf-binutils/bin/i386-elf-ld.exe

CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra -Iinclude
ASFLAGS = --32

C_SOURCES = $(wildcard src/*.c)
C_OBJECTS = $(patsubst src/%.c,build/%.o,$(C_SOURCES))

OBJS = build/boot.o $(C_OBJECTS)

TARGET = build/myos.bin

QEMU = qemu-system-i386

.PHONY: all run clean

all: $(TARGET)

build:
	mkdir -p build

build/boot.o: boot.asm | build
	nasm -f elf32 $< -o $@

build/%.o: src/%.c | build
	$(CC) $(CFLAGS) -S $< -o build/$*.s
	$(AS) $(ASFLAGS) build/$*.s -o $@

$(TARGET): $(OBJS)
	$(LD) -T linker.ld -o $@ $(OBJS)

run: $(TARGET)
	$(QEMU) -kernel $(TARGET)

clean:
	rm -rf build