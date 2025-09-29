; BITS: 64
; SOURCE: FEX TwoByte/0F_28.asm
; FEX_SHA256: 3ef137262d3676c32968c50cf3095863e1839b5f89e0699d9e1e84ec33a27d85
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

hlt