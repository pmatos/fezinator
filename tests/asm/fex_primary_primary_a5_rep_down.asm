; BITS: 64
; SOURCE: FEX Primary/Primary_A5_REP_Down.asm
; FEX_SHA256: 3e1ce338f7b3606b25e247ed466177a7b0520bc0292d115ce5e70b98df1f4b95
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
rep movsw ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt