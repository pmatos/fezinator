; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_00.asm
; FEX_SHA256: 523d95000bdb761ca9b33d245b408600949dd4d8c9a52dc1ddc8aed3405a17ad
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

add byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt