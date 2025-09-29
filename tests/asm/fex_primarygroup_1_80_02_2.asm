; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_02_2.asm
; FEX_SHA256: ab5caa51d4cbf7d593fe2853cd67344f732746b9fa3a8092c47f28fb691d0dc7
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

clc
lock adc byte [rdx + 8 * 0 + 1], 0x61

stc
lock adc byte [rdx + 8 * 0 + 2], 0x61

mov rax, [rdx + 8 * 0]

hlt