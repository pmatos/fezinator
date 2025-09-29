; BITS: 64
; SOURCE: FEX Primary/Primary_A5_dword_REPNE_Down.asm
; FEX_SHA256: 7db1a9257cf83ca8cd16fa4b485253bf4d5dee2566216d9c2d5121c723edd8e1
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 4]
lea rsi, [rdx + 8 * 0 + 4]

std
mov rcx, 2
repne movsd ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt