BITS 64

; from: https://software.intel.com/sites/default/files/article/165683/aes-wp-2012-09-22-v01.pdf
%macro generate_round_key 3
    aeskeygenassist xmm2, xmm1, %1

    pshufd xmm2, xmm2, 0xff
    vpslldq xmm3, xmm1, 0x4
    pxor xmm1, xmm3
    vpslldq xmm3, xmm1, 0x4
    pxor xmm1, xmm3
    vpslldq xmm3, xmm1, 0x4
    pxor xmm1, xmm3
    pxor xmm1, xmm2

    %if %2 = 1
        aesimc %3, xmm1
    %else
        movdqa %3, xmm1
    %endif
%endmacro

global aes_128_encrypt:
aes_128_encrypt:
    movdqa xmm0, [rdi] ; data
    movdqa xmm1, [rsi] ; key

    movdqa xmm5, xmm1
    generate_round_key 0x1, 0, xmm6
    generate_round_key 0x2, 0, xmm7
    generate_round_key 0x4, 0, xmm8
    generate_round_key 0x8, 0, xmm9
    generate_round_key 0x10, 0, xmm10
    generate_round_key 0x20, 0, xmm11
    generate_round_key 0x40, 0, xmm12
    generate_round_key 0x80, 0, xmm13
    generate_round_key 0x1b, 0, xmm14
    generate_round_key 0x36, 0, xmm15

    pxor xmm0, xmm5
    aesenc xmm0, xmm6
    aesenc xmm0, xmm7
    aesenc xmm0, xmm8
    aesenc xmm0, xmm9
    aesenc xmm0, xmm10
    aesenc xmm0, xmm11
    aesenc xmm0, xmm12
    aesenc xmm0, xmm13
    aesenc xmm0, xmm14
    aesenclast xmm0, xmm15

    movdqa [rdi], xmm0
    ret

global aes_128_decrypt
aes_128_decrypt:
    movdqa xmm0, [rdi] ; data
    movdqa xmm1, [rsi] ; key

    movdqa xmm5, xmm1
    generate_round_key 0x1, 1, xmm6
    generate_round_key 0x2, 1, xmm7
    generate_round_key 0x4, 1, xmm8
    generate_round_key 0x8, 1, xmm9
    generate_round_key 0x10, 1, xmm10
    generate_round_key 0x20, 1, xmm11
    generate_round_key 0x40, 1, xmm12
    generate_round_key 0x80, 1, xmm13
    generate_round_key 0x1b, 1, xmm14
    generate_round_key 0x36, 0, xmm15

    pxor xmm0, xmm15
    aesdec xmm0, xmm14
    aesdec xmm0, xmm13
    aesdec xmm0, xmm12
    aesdec xmm0, xmm11
    aesdec xmm0, xmm10
    aesdec xmm0, xmm9
    aesdec xmm0, xmm8
    aesdec xmm0, xmm7
    aesdec xmm0, xmm6
    aesdeclast xmm0, xmm5

    movdqa [rdi], xmm0
    ret
