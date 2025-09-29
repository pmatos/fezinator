; BITS: 64
; SOURCE: FEX Primary/Primary_AB_word_REP_down.asm
; FEX_SHA256: 3828ff3beb05c3b48a5da7d57c68461d2a71ccea078b2d6b21715361d89d1cb4
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 6]

std
mov rcx, 0x4
mov rax, 0xF1F2
rep stosw ; rdi <- ax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt