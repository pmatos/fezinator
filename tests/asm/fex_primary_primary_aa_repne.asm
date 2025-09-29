; BITS: 64
; SOURCE: FEX Primary/Primary_AA_REPNE.asm
; FEX_SHA256: ed94a8f8633d2bdfa89ef5a6868e6bd3ae5b3d0b393a0b2a4f1ae3c0c657a958
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
mov rcx, 8
mov rax, 0xF2
repne stosb ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt