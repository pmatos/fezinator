; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_03_2.asm
; FEX_SHA256: 060a58adc530c5e43b14fc0d65fb137f947563e6c3af7b6e3ab9469f51090f66
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

clc
lock sbb byte [rdx + 8 * 0 + 1], 0x61

stc
lock sbb byte [rdx + 8 * 0 + 2], 0x61

mov rax, [rdx + 8 * 0]

hlt