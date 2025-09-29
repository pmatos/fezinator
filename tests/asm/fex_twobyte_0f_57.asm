; BITS: 64
; SOURCE: FEX TwoByte/0F_57.asm
; FEX_SHA256: 9a1390030e6a04a95e5c7dd0c8cbdc9c9aa03b507286fee0b7bcb5a81d9a864c
mov rdx, 0xe0000000

mov rax, 0x3C3C3C3C3C3C3C3C
mov [rdx + 8 * 0], rax
mov rax, 0x3C3C3C3C3C3C3C3C
mov [rdx + 8 * 1], rax

mov rax, 0x1818181818181818
mov [rdx + 8 * 2], rax
mov rax, 0x1818181818181818
mov [rdx + 8 * 3], rax

movapd xmm0, [rdx]
xorps xmm0, [rdx + 8 * 2]

movapd xmm1, [rdx]
movapd xmm2, [rdx + 8 * 2]
xorps xmm1, xmm2

hlt