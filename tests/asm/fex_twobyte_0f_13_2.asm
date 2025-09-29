; BITS: 64
; SOURCE: FEX TwoByte/0F_13_2.asm
; FEX_SHA256: 499032ed757c6853947ba3928355dd23efb2a5735982aac43c66ab7229adaeed
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
movlps xmm0, [rdx + 8 * 2]

hlt