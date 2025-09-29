; BITS: 64
; SOURCE: FEX TwoByte/0F_16.asm
; FEX_SHA256: ef2f17710cbc8b05c68e5e1d7576de0b740a1243886f3bb0112fbc0392455d59
lea rdx, [rel .data]

movaps xmm0, [rdx]
movaps xmm1, [rdx + 16]

movlhps xmm0, xmm1

hlt

align 16
.data:
dq 0x4142434445464748
dq 0x5152535455565758

dq 0x6162636465666768
dq 0x7172737475767778