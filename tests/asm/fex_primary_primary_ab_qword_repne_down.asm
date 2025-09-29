; BITS: 64
; SOURCE: FEX Primary/Primary_AB_qword_REPNE_down.asm
; FEX_SHA256: dd3e4a292b0bbd58fc2a63e534017da0e1aed6ce10f22e318753492ae4c1ded9
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax
mov [rdx + 8 * 4], rax

lea rdi, [rdx + 8 * 3]

std
mov rax, 0xF1F2F3F4F5F6F7F8
mov rcx, 2
repne stosq ; rdi <- rax

mov rax, [rdx + 8 * 2]
mov rsi, [rdx + 8 * 4]
mov rdx, [rdx + 8 * 3]
hlt