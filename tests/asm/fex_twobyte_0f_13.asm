; BITS: 64
; SOURCE: FEX TwoByte/0F_13.asm
; FEX_SHA256: b81c1b4897ce9752d1c708c3f70611030a3d764d8728628b19e50cefe7803d2b
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
movlps [rdx + 8 * 2], xmm0
movaps xmm0, [rdx + 8 * 2]

hlt