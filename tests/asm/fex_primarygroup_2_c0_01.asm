; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_01.asm
; FEX_SHA256: a7ff1ca0737c72d258222c0fcde232f1c1b3d9e337428e938ad4745ba423936d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

ror byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt