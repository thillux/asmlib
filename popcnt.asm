BITS 64

global population_count_u16
population_count_u16:
    xor rax, rax
    popcnt ax, di

global population_count_u32
population_count_u32:
    xor rax, rax
    popcnt eax, edi

global population_count_u64
population_count_u64:
    xor rax, rax
    popcnt rax, rdi
