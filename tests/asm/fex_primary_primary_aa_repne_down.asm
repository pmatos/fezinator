; BITS: 64
; SOURCE: FEX Primary/Primary_AA_REPNE_down.asm
; FEX_SHA256: 15c6aa1b754faaeb101213a9a1a860eae3edb48721abb824cb4f31717499c9d4
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 7]

std
mov rcx, 8
mov rax, 0xF2
repne stosb ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt