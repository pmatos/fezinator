; BITS: 64
; SOURCE: FEX Primary/Primary_AB_dword_REPNE.asm
; FEX_SHA256: 179e9f72e9dc26575a28920ecfe8bce63f816360e81e265004e2e15c5dfc9404
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
mov rax, 0xF1F2F3F4
mov rcx, 2
repne stosd ; rdi <- eax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt