; BITS: 64
; SOURCE: FEX Primary/Primary_AF_REP_word.asm
; FEX_SHA256: 042dd3bff6837790d8ba5d4e09129ac1b316de76c37f539f94c0c8ff7a0d882e
mov rdx, 0xe0000000

mov rax, 0x4142434445466162
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 0]

cld
mov rax, 0x6162
mov rcx, 8
cmp rax, 0x6162

rep scasw

hlt