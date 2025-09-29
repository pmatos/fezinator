; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_02.asm
; FEX_SHA256: e2274fe175d404d9a3fb08b91a6549f19c41c6b684a143028990b06217ee74e3
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

clc
adc byte [rdx + 8 * 0 + 1], 0x61

stc
adc byte [rdx + 8 * 0 + 2], 0x61

mov rax, [rdx + 8 * 0]

hlt