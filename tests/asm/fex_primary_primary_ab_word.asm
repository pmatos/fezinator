; BITS: 64
; SOURCE: FEX Primary/Primary_AB_word.asm
; FEX_SHA256: eb6fe3c40c863868719cc9cdcab753c1e39966f6aa5b44d040655c78cf8a4f56
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]

cld
mov rax, 0xF1F2
stosw ; rdi <- ax
stosw
stosw
stosw

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt