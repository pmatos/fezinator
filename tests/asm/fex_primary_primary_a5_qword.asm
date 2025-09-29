; BITS: 64
; SOURCE: FEX Primary/Primary_A5_qword.asm
; FEX_SHA256: 864b4218833fec8d2524e90af84774c54e53bae4402d2fdc5fccc53f9a48e513
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax
mov [rdx + 8 * 4], rax

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
movsq ; rdi <- rsi
movsq

mov rax, [rdx + 8 * 2]
mov rbx, [rdx + 8 * 3]
mov rcx, [rdx + 8 * 4]
hlt