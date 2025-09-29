; BITS: 64
; SOURCE: FEX TwoByte/0F_55.asm
; FEX_SHA256: ebc6ceedfa8feb05e03e9abe568d35ea74bb205f6f5fd32e1f635ce0455e9f0d
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
andnps xmm0, [rdx + 8 * 2]

movapd xmm1, [rdx]
movapd xmm2, [rdx + 8 * 2]
andnps xmm1, xmm2

hlt