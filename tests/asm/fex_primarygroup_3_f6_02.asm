; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_02.asm
; FEX_SHA256: 7751e0a41111fb0ea85bfb7b089fb8e2d03a8c14e7c7d5196cf4d6050690734e
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

not byte [rdx + 8 * 0 + 1]

mov rax, [rdx + 8 * 0]

hlt