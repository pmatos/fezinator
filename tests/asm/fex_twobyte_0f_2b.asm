; BITS: 64
; SOURCE: FEX TwoByte/0F_2B.asm
; FEX_SHA256: 747d850fa3c7baf235f7f6e54a4dd49ef8f72f29e0d3f367f72345066be59a98
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

movaps xmm0, [rdx + 8 * 0]
movntps [rdx + 8 * 2], xmm0
movaps xmm1, [rdx + 8 * 2]


hlt