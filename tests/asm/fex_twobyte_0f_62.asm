; BITS: 64
; SOURCE: FEX TwoByte/0F_62.asm
; FEX_SHA256: b198ddf933592632806f47e4e2beafa59e23dc39cb64fc1f4b99225d0315dbdb
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
punpckldq mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
punpckldq mm1, mm2

hlt