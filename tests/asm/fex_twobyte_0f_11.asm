; BITS: 64
; SOURCE: FEX TwoByte/0F_11.asm
; FEX_SHA256: 581283479656f66cda901d54735f74b33e978be2feb90692e484325890df517e
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

movaps xmm0, [rdx + 8 * 0]
movups [rdx + 8 * 2], xmm0
movaps xmm1, [rdx + 8 * 2]

hlt