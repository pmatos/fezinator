; BITS: 64
; SOURCE: FEX Primary/Primary_AB_dword_REPNE_down.asm
; FEX_SHA256: 5d578d1ae781243259cf30ffd19edc45ac13f85bf7ac5a2dcdd0167b9aacb114
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 4]

std
mov rax, 0xF1F2F3F4
mov rcx, 2
repne stosd ; rdi <- eax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt