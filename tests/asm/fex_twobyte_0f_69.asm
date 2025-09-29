; BITS: 64
; SOURCE: FEX TwoByte/0F_69.asm
; FEX_SHA256: 4da82b6001ae008dc1e1e9fc58c222fb900a1732c0a9a8d049636831277fa661
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
punpckhwd mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
punpckhwd mm1, mm2

hlt