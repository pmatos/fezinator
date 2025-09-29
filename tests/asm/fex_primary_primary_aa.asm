; BITS: 64
; SOURCE: FEX Primary/Primary_AA.asm
; FEX_SHA256: cbb3d1d6785644b4c2c0b760d1cecb1f069f60bd14a507b0e849fb7a71972f92
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
mov rax, 0xF2
stosb ; rdi <- al
stosb
stosb
stosb

stosb
stosb
stosb
stosb

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt