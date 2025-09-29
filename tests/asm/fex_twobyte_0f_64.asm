; BITS: 64
; SOURCE: FEX TwoByte/0F_64.asm
; FEX_SHA256: 2e53eb4523243f9585416732517ca411e5fdd8bfa3f13cda45ae48639473cfb7
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
pcmpgtb mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
pcmpgtb mm1, mm2

hlt