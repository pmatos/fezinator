; BITS: 64
; SOURCE: FEX TwoByte/0F_5C.asm
; FEX_SHA256: a2fa2209237d2a00e6985604a171359dd4e2ce3f56231901dd4d3c23339cfb7d
mov rdx, 0xe0000000

mov rax, 0x400000003f800000 ; 2, 1
mov [rdx + 8 * 0], rax
mov rax, 0x4080000040400000 ; 4, 3
mov [rdx + 8 * 1], rax

mov rax, 0x40c0000040a00000 ; 6, 5
mov [rdx + 8 * 2], rax
mov rax, 0x4100000040e00000 ; 8, 7
mov [rdx + 8 * 3], rax

movapd xmm0, [rdx]
subps xmm0, [rdx + 8 * 2]

movapd xmm1, [rdx]
movapd xmm2, [rdx + 8 * 2]
subps xmm1, xmm2

hlt