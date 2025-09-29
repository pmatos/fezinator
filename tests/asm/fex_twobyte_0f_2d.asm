; BITS: 64
; SOURCE: FEX TwoByte/0F_2D.asm
; FEX_SHA256: c9d780eb213d8b1a9ad66c5af0af2fa765313a1e8c6ae9c507fc89ed649556b0
mov rdx, 0xe0000000

mov rax, 0x3f80000040000000
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

movq mm0, [rdx + 8 * 2]
movaps xmm0, [rdx + 8 * 0]

cvtps2pi mm0, xmm0

hlt