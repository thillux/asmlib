BITS 64

global crc32_u8
crc32_u8:
  crc32 rsi, dil
  mov rax, rsi
  ret

global crc32_u16
crc32_u16:
  crc32 edi, si
  mov rax, rdi
  ret

global crc32_u32
crc32_u32:
  crc32 edi, esi
  mov rax, rdi
  ret

global crc32_u64
crc32_u64:
  crc32 rdi, rsi
  mov rax, rdi
  ret
