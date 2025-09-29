; BITS: 64
; SOURCE: FEX TwoByte/0F_66.asm
; FEX_SHA256: b5890cca34d68d5f4838a0c591419895270ca5a1af6f3800a6caa389c535d488
mov rdx, 0xe0000000

mov rax, 0x7172737475767778
mov [rdx + 8 * 0], rax
mov rax, 0x4142434445464748
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
pcmpgtd mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
pcmpgtd mm1, mm2

hlt