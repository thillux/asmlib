#ifndef POPCNT_H
#define POPCNT_H

#include <stdint.h>

extern uint16_t population_count_u16(uint16_t to_count);
extern uint32_t population_count_u32(uint32_t to_count);
extern uint64_t population_count_u64(uint64_t to_count);

#endif
