; BITS: 64
; SOURCE: FEX Primary/Primary_AB_word_REPNE_down.asm
; FEX_SHA256: 4170760f3a0a62f9fa8429ecad849dd400f1bb365bb315130398993eb9554080
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2 + 6]

std
mov rcx, 0x4
mov rax, 0xF1F2
repne stosw ; rdi <- ax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt