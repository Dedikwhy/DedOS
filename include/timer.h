#ifndef TIMER_H
#define TIMER_H

#include <stdint.h>

// Время без прерываний: PIT читается по polling, поэтому timer_ms()
// нужно дёргать чаще, чем раз в ~50 мс (главный цикл GUI так и делает).
void     timer_init(void);
uint32_t timer_ms(void);

typedef struct { int year, month, day, hour, minute, second; } rtc_time_t;
void rtc_get(rtc_time_t *t);

#endif
