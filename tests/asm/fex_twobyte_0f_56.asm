; BITS: 64
; SOURCE: FEX TwoByte/0F_56.asm
; FEX_SHA256: ae8ca0c01ff028a0ecfb1b0117fa75dbf991c6c8b9df3728ed61ae7e247e9d24
mov rdx, 0xe0000000

mov rax, 0x1010101010101010
mov [rdx + 8 * 0], rax
mov rax, 0x2020202020202020
mov [rdx + 8 * 1], rax

mov rax, 0x0101010101010101
mov [rdx + 8 * 2], rax
mov rax, 0x0202020202020202
mov [rdx + 8 * 3], rax

movapd xmm0, [rdx]
orps xmm0, [rdx + 8 * 2]

movapd xmm1, [rdx]
movapd xmm2, [rdx + 8 * 2]
orps xmm1, xmm2

hlt