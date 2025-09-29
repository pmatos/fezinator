; BITS: 64
; SOURCE: FEX TwoByte/0F_17.asm
; FEX_SHA256: e3e1f8e9fa16cc62d9b6648c236fd777d6fe75508490f82a6106df3e2a9b8a07
lea rdx, [rel .data]

; Into register
movaps xmm0, [rdx]
movhps xmm0, [rdx + 16]

; Into memory (should only store upper half of xmm into 64-bit region of memory)
movhps [rdx + 32], xmm0
movaps xmm1, [rdx + 32]

hlt

align 16
.data:
dq 0x4142434445464748
dq 0x5152535455565758

dq 0x6162636465666768
dq 0x7172737475767778

dq 0xFFFFFFFFFFFFFFFF
dq 0xFFFFFFFFFFFFFFFF