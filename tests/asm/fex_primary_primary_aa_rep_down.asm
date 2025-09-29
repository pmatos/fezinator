; BITS: 64
; SOURCE: FEX Primary/Primary_AA_REP_down.asm
; FEX_SHA256: 88088ed6293f3435dd609e0bb8afd40be26a97a17e12922c65820a52994d2bfa
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
rep stosb ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt