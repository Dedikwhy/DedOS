# DedOS - сборка.
# Тулчейн выбирается сам: старый Windows-кросс из WSL -> i686-elf-gcc -> системный gcc -m32.

WIN_CROSS := /mnt/c/i868-elf
ifneq ($(wildcard $(WIN_CROSS)/i386-elf-gcc/bin/i386-elf-gcc.exe),)
  CC := $(WIN_CROSS)/i386-elf-gcc/bin/i386-elf-gcc.exe
  AS := $(WIN_CROSS)/i386-elf-binutils/bin/i386-elf-as.exe
  LD := $(WIN_CROSS)/i386-elf-binutils/bin/i386-elf-ld.exe
else ifneq ($(shell command -v i686-elf-gcc 2>/dev/null),)
  CC := i686-elf-gcc
  AS := i686-elf-as
  LD := i686-elf-ld
else
  CC := gcc -m32
  AS := as --32
  LD := ld -m elf_i386
endif

CFLAGS  = -std=gnu99 -ffreestanding -fno-pie -fno-stack-protector \
          -fno-tree-loop-distribute-patterns -mno-sse -mno-mmx \
          -O2 -Wall -Wextra -Iinclude
ASFLAGS = --32

C_SOURCES = $(wildcard src/*.c)
C_OBJECTS = $(patsubst src/%.c,build/%.o,$(C_SOURCES))
OBJS      = build/boot.o $(C_OBJECTS)
TARGET    = build/myos.bin
ISO       = DedOS.iso

QEMU       = qemu-system-i386
QEMU_FLAGS = -vga std -m 128M -rtc base=localtime

.PHONY: all run iso run-iso clean

all: $(TARGET)

build:
	mkdir -p build

build/boot.o: boot.asm | build
	nasm -f elf32 $< -o $@

build/%.o: src/%.c $(wildcard include/*.h) | build
	$(CC) $(CFLAGS) -S $< -o build/$*.s
	$(AS) $(ASFLAGS) build/$*.s -o $@

$(TARGET): $(OBJS) linker.ld
	$(LD) -T linker.ld -o $@ $(OBJS)

run: $(TARGET)
	$(QEMU) -kernel $(TARGET) $(QEMU_FLAGS)

iso: $(TARGET)
	grub-file --is-x86-multiboot $(TARGET)
	rm -rf build/iso && mkdir -p build/iso/boot/grub
	cp $(TARGET) build/iso/boot/myos.bin
	cp grub/grub.cfg build/iso/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) build/iso

run-iso: iso
	$(QEMU) -cdrom $(ISO) $(QEMU_FLAGS)

clean:
	rm -rf build $(ISO)
