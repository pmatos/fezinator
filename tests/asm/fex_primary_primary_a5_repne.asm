; BITS: 64
; SOURCE: FEX Primary/Primary_A5_REPNE.asm
; FEX_SHA256: 67f936fc05b4e4ee62086ede254eae16827e7305f2d5bb1bd7e8b51db3e8972f
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 4
repne movsw ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt