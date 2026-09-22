#include "timer.h"
#include "io.h"

#define PIT_HZ        1193182u
#define PIT_TICKS_MS  1193u

static uint16_t s_last;
static uint32_t s_frac;
static uint32_t s_ms;

static uint16_t pit_read(void) {
    outb(0x43, 0x00);                 // защёлкнуть счётчик канала 0
    uint8_t lo = inb(0x40);
    uint8_t hi = inb(0x40);
    return (uint16_t)(lo | (hi << 8));
}

void timer_init(void) {
    outb(0x43, 0x34);                 // канал 0, lo/hi, режим 2, бинарный
    outb(0x40, 0x00);
    outb(0x40, 0x00);                 // перезагрузка 65536 (~18.2 Гц, срабатывает раз в 55 мс)
    s_last = pit_read();
    s_frac = 0;
    s_ms = 0;
}

uint32_t timer_ms(void) {
    uint16_t now = pit_read();
    s_frac += (uint16_t)(s_last - now);   // счётчик считает вниз
    s_last = now;
    while (s_frac >= PIT_TICKS_MS) { s_frac -= PIT_TICKS_MS; s_ms++; }
    return s_ms;
}

// ---------- RTC (CMOS) ----------

static uint8_t cmos_read(uint8_t reg) {
    outb(0x70, reg);
    return inb(0x71);
}

static int bcd(int v) { return (v & 0x0F) + (v >> 4) * 10; }

void rtc_get(rtc_time_t *t) {
    for (int guard = 0; guard < 100000 && (cmos_read(0x0A) & 0x80); guard++) {}

    uint8_t s = cmos_read(0x00), m = cmos_read(0x02), h = cmos_read(0x04);
    uint8_t d = cmos_read(0x07), mo = cmos_read(0x08), y = cmos_read(0x09);
    uint8_t b = cmos_read(0x0B);

    int pm = h & 0x80;
    h &= 0x7F;
    if (!(b & 0x04)) {
        s = (uint8_t)bcd(s); m = (uint8_t)bcd(m); h = (uint8_t)bcd(h);
        d = (uint8_t)bcd(d); mo = (uint8_t)bcd(mo); y = (uint8_t)bcd(y);
    }
    if (!(b & 0x02)) {                // 12-часовой формат
        if (h == 12) h = 0;
        if (pm) h += 12;
    }
    t->second = s; t->minute = m; t->hour = h;
    t->day = d; t->month = mo; t->year = 2000 + y;
}
