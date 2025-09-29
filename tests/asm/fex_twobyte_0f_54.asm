; BITS: 64
; SOURCE: FEX TwoByte/0F_54.asm
; FEX_SHA256: 1bff7118788dad00bcd754d062a7608cc3d2ed175286f2d196de64d867929fbd
mov rdx, 0xe0000000

mov rax, 0xFFFFFFFFFFFFFFFF
mov [rdx + 8 * 0], rax
mov rax, 0x0
mov [rdx + 8 * 1], rax

mov rax, 0x1010101010101010
mov [rdx + 8 * 2], rax
mov rax, 0xFFFFFFFFFFFFFFFF
mov [rdx + 8 * 3], rax

movapd xmm0, [rdx]
andps xmm0, [rdx + 8 * 2]

movapd xmm1, [rdx]
movapd xmm2, [rdx + 8 * 2]
andps xmm1, xmm2

hlt