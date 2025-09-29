; BITS: 64
; SOURCE: FEX TwoByte/0F_60.asm
; FEX_SHA256: 250a69852dea3e4b8aaa7eab18bca18d57f4d045d90277c6ae557285e7056101
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
punpcklbw mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
punpcklbw mm1, mm2

hlt