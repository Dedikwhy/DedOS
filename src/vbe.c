#include "vbe.h"

// ---------- порты ввода-вывода ----------
static inline void outb(uint16_t port, uint8_t val) {
    __asm__ volatile ("outb %0, %1" : : "a"(val), "Nd"(port));
}
static inline void outw(uint16_t port, uint16_t val) {
    __asm__ volatile ("outw %0, %1" : : "a"(val), "Nd"(port));
}
static inline void outl(uint16_t port, uint32_t val) {
    __asm__ volatile ("outl %0, %1" : : "a"(val), "Nd"(port));
}
static inline uint32_t inl(uint16_t port) {
    uint32_t ret;
    __asm__ volatile ("inl %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

// ---------- PCI ----------
#define PCI_CONFIG_ADDR 0xCF8
#define PCI_CONFIG_DATA 0xCFC

static uint32_t pci_read32(uint8_t bus, uint8_t slot, uint8_t func, uint8_t offset) {
    uint32_t address = (uint32_t)((1u << 31) | (bus << 16) | (slot << 11) |
                                   (func << 8) | (offset & 0xFC));
    outl(PCI_CONFIG_ADDR, address);
    return inl(PCI_CONFIG_DATA);
}

// Ищем первое VGA-совместимое устройство (class 0x03, subclass 0x00) на bus 0.
// Возвращает 1 и заполняет bar0, если нашли; иначе 0.
static int pci_find_vga(uint8_t *out_bus, uint8_t *out_slot, uint32_t *out_bar0) {
    for (uint16_t slot = 0; slot < 32; slot++) {
        uint32_t id = pci_read32(0, (uint8_t)slot, 0, 0x00);
        uint16_t vendor = id & 0xFFFF;
        if (vendor == 0xFFFF) continue; // нет устройства

        uint32_t classreg = pci_read32(0, (uint8_t)slot, 0, 0x08);
        uint8_t class_code = (classreg >> 24) & 0xFF;
        uint8_t subclass   = (classreg >> 16) & 0xFF;

        if (class_code == 0x03 && subclass == 0x00) {
            uint32_t bar0 = pci_read32(0, (uint8_t)slot, 0, 0x10);
            *out_bus = 0;
            *out_slot = (uint8_t)slot;
            *out_bar0 = bar0 & 0xFFFFFFF0; // отбрасываем флаговые биты
            return 1;
        }
    }
    return 0;
}

// ---------- Bochs / QEMU stdvga Dispi-интерфейс ----------
#define VBE_DISPI_IOPORT_INDEX 0x01CE
#define VBE_DISPI_IOPORT_DATA  0x01CF

#define VBE_DISPI_INDEX_XRES        0x1
#define VBE_DISPI_INDEX_YRES        0x2
#define VBE_DISPI_INDEX_BPP         0x3
#define VBE_DISPI_INDEX_ENABLE      0x4
#define VBE_DISPI_INDEX_VIRT_WIDTH  0x6
#define VBE_DISPI_INDEX_VIRT_HEIGHT 0x7

#define VBE_DISPI_DISABLED    0x00
#define VBE_DISPI_ENABLED     0x01
#define VBE_DISPI_LFB_ENABLED 0x40

static void dispi_write(uint16_t index, uint16_t value) {
    outw(VBE_DISPI_IOPORT_INDEX, index);
    outw(VBE_DISPI_IOPORT_DATA, value);
}

static vbe_info_t g_vbe = {0, 0, 0, 0};

int vbe_init(uint32_t width, uint32_t height, uint32_t bpp) {
    uint8_t bus, slot;
    uint32_t bar0;

    if (!pci_find_vga(&bus, &slot, &bar0)) {
        return 0; // нет подходящей видеокарты (не под QEMU/Bochs VBE?)
    }
    if (bar0 == 0) {
        return 0;
    }

    dispi_write(VBE_DISPI_INDEX_ENABLE, VBE_DISPI_DISABLED);
    dispi_write(VBE_DISPI_INDEX_XRES, (uint16_t)width);
    dispi_write(VBE_DISPI_INDEX_YRES, (uint16_t)height);
    dispi_write(VBE_DISPI_INDEX_BPP, (uint16_t)bpp);
    dispi_write(VBE_DISPI_INDEX_VIRT_WIDTH, (uint16_t)width);
    dispi_write(VBE_DISPI_INDEX_VIRT_HEIGHT, (uint16_t)height);
    dispi_write(VBE_DISPI_INDEX_ENABLE, VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);

    g_vbe.fb     = (uint32_t *)bar0;
    g_vbe.width  = width;
    g_vbe.height = height;
    g_vbe.pitch  = width * (bpp / 8);

    return 1;
}

const vbe_info_t *vbe_get_info(void) {
    return &g_vbe;
}
