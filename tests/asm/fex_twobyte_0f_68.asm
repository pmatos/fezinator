; BITS: 64
; SOURCE: FEX TwoByte/0F_68.asm
; FEX_SHA256: c7412d244cd4ba479d384a622ac48fd484e60359fde97d5ae25e753c4a576ff7
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
punpckhbw mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
punpckhbw mm1, mm2

hlt