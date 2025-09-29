; BITS: 64
; SOURCE: FEX Primary/Primary_A5.asm
; FEX_SHA256: 9634f80852e74a7c5cd625bd79fa9b81cbb4760bbcaa4263d0fce635c5720711
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
movsw ; rdi <- rsi
movsw

movsw
movsw

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt