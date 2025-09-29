; BITS: 64
; SOURCE: FEX Primary/Primary_AB_qword.asm
; FEX_SHA256: 0f00bfaffda90a7083ad205cea865d414156a141be596498a445372b11fe681b
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
mov rax, 0xF1F2F3F4F5F6F7F8
stosq ; rdi <- rax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt