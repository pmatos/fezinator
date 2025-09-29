; BITS: 64
; SOURCE: FEX Primary/Primary_A5_qword_REPNE_Down.asm
; FEX_SHA256: 7d144273e01e8a310eaab62b8f909d9ae6c31511482c932161b9feb31fe20a31
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax
mov [rdx + 8 * 4], rax

lea rdi, [rdx + 8 * 3]
lea rsi, [rdx + 8 * 1]

std
mov rcx, 2
repne movsq ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rbx, [rdx + 8 * 3]
mov rcx, [rdx + 8 * 4]
hlt