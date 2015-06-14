#ifndef CRC32_H
#define CRC32_H

#include <stdint.h>

extern uint32_t crc32_u8(uint32_t crc, uint8_t data);
extern uint32_t crc32_u16(uint32_t crc, uint16_t data);
extern uint32_t crc32_u32(uint32_t crc, uint32_t data);
extern uint64_t crc32_u64(uint64_t crc, uint64_t data);

#endif
