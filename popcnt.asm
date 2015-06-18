BITS 64

global population_count_u16
population_count_u16:
    popcnt ax, di
    ret

global population_count_u32
population_count_u32:
    popcnt eax, edi
    ret

global population_count_u64
population_count_u64:
    popcnt rax, rdi
    ret
