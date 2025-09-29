; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_03.asm
; FEX_SHA256: 7b34a970ca45c1845343f2c22df408d783c06b2247c833d87d2bbea40d6ccdce
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

neg byte [rdx + 8 * 0 + 1]

mov rax, [rdx + 8 * 0]

hlt