; BITS: 64
; SOURCE: FEX TwoByte/0F_12.asm
; FEX_SHA256: 5c079003eb7bb8fa4ad11f6f3d6cde61e5346676d7d7701e4b4830c7c4c28d20
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

movaps xmm0, [rdx + 8 * 0]
movaps xmm1, [rdx + 8 * 2]
movhlps xmm0, xmm1

hlt