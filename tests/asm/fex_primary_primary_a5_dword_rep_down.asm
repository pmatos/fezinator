; BITS: 64
; SOURCE: FEX Primary/Primary_A5_dword_REP_Down.asm
; FEX_SHA256: a46b96d04fa5834017e05237abe56907c34c4334453c617e8b3d5dedf361cf71
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 4]
lea rsi, [rdx + 8 * 0 + 4]

std
mov rcx, 2
rep movsd ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt