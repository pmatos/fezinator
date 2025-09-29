; BITS: 64
; SOURCE: FEX Primary/Primary_AA_REP.asm
; FEX_SHA256: 2762c463059c9b74179f31acc915143538d329e2259962d6137699701122d04f
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
rep stosb ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt