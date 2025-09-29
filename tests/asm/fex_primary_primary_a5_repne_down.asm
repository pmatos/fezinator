; BITS: 64
; SOURCE: FEX Primary/Primary_A5_REPNE_Down.asm
; FEX_SHA256: 45c456bb2465dfdf146fa9642a3f17fe7a1e6fc461c6c39242338dc7b6692e59
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 6]
lea rsi, [rdx + 8 * 0 + 6]

std
mov rcx, 4
repne movsw ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt