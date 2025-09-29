; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_03.asm
; FEX_SHA256: 1cbcdd5f2da252cdcb5ef3795dedd931362098594e9763b684bad04bc00e5b07
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

clc
sbb byte [rdx + 8 * 0 + 1], 0x61

stc
sbb byte [rdx + 8 * 0 + 2], 0x61

mov rax, [rdx + 8 * 0]

hlt