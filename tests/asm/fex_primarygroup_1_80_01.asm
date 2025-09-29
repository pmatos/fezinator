; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_01.asm
; FEX_SHA256: 86b225dab05363210e42002f5cac617fe3de5856dd86f8d5d48f2975987b1705
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

or byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt