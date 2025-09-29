; BITS: 64
; SOURCE: FEX TwoByte/0F_51.asm
; FEX_SHA256: 75d4729a128ba16fe8c139eca3ce096596ac223a46e4f035dcf6f744566e0087
mov rdx, 0xe0000000

mov rax, 0x3f8000003f800000 ; 1.0
mov [rdx + 8 * 0], rax
mov rax, 0x3f8000003f800000
mov [rdx + 8 * 1], rax

mov rax, 0x4080000040800000 ; 4.0
mov [rdx + 8 * 2], rax
mov rax, 0x4080000040800000
mov [rdx + 8 * 3], rax

mov rax, 0x4110000041100000 ; 9.0
mov [rdx + 8 * 4], rax
mov rax, 0x4110000041100000
mov [rdx + 8 * 5], rax

mov rax, 0x4180000041800000 ; 16.0
mov [rdx + 8 * 6], rax
mov rax, 0x4180000041800000
mov [rdx + 8 * 7], rax

mov rax, 0x41c8000041c80000 ; 25.0
mov [rdx + 8 * 8], rax
mov rax, 0x41c8000041c80000
mov [rdx + 8 * 9], rax

movapd xmm0, [rdx + 8 * 0]
movapd xmm1, [rdx + 8 * 2]
movapd xmm2, [rdx + 8 * 4]
movapd xmm3, [rdx + 8 * 6]
movapd xmm4, [rdx + 8 * 8]
movapd xmm5, [rdx + 8 * 8]
movapd xmm6, [rdx + 8 * 8]
movapd xmm7, [rdx + 8 * 8]

sqrtps xmm0, xmm0
sqrtps xmm1, xmm1
sqrtps xmm2, xmm2
sqrtps xmm3, xmm3

sqrtps xmm4, [rdx + 8 * 0]
sqrtps xmm5, [rdx + 8 * 2]
sqrtps xmm6, [rdx + 8 * 4]
sqrtps xmm7, [rdx + 8 * 6]

hlt