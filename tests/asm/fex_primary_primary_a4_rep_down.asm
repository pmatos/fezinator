; BITS: 64
; SOURCE: FEX Primary/Primary_A4_REP_Down.asm
; FEX_SHA256: da6bbffbb7a11448f76fd773712ba5c4c6f8e9622c655ed3ff430154079194ba
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 7]
lea rsi, [rdx + 8 * 0 + 7]

std
mov rcx, 8
rep movsb ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt