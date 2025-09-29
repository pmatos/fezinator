; BITS: 64
; SOURCE: FEX TwoByte/0F_61.asm
; FEX_SHA256: ad095da9cd1eae53335abf15f0695109dea194b97ae018d17ac2a2eb0fb53fb1
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
punpcklwd mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
punpcklwd mm1, mm2

hlt