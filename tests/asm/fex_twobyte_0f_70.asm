; BITS: 64
; SOURCE: FEX TwoByte/0F_70.asm
; FEX_SHA256: bcd3c0b69a4ef02782b321e615797c00b47f365c99f712e9ad1e1e12bf6a21cb
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
movq mm1, [rdx + 8 * 2]
pshufw mm2, mm0, 0x0
pshufw mm3, mm1, 0xFF

hlt