; BITS: 64
; SOURCE: FEX Primary/Primary_AB_dword_REP.asm
; FEX_SHA256: d1febb49e6ded6fbc610f8e47e6914e5ab479805de5544ba5a1a71963c51cd08
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
rep stosd ; rdi <- eax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt