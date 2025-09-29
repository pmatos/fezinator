; BITS: 64
; SOURCE: FEX TwoByte/0F_7F.asm
; FEX_SHA256: 089eac08b805ac1578e7d541c432a20d5b4e0a5d3a0012d890504c9c7f12f554
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

mov rax, 0x0
mov [rdx + 8 * 4], rax
mov [rdx + 8 * 5], rax

movq mm0, [rdx + 8 * 0]
movq mm1, [rdx + 8 * 1]
movq [rdx + 8 * 4], mm0
movq mm1, [rdx + 8 * 4]

hlt