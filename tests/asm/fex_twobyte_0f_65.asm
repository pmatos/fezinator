; BITS: 64
; SOURCE: FEX TwoByte/0F_65.asm
; FEX_SHA256: 85f4c4d242def8f4ac0270f77721fbc22e3e0d0e198817dd2b85939d73ad51f9
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
pcmpgtw mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
pcmpgtw mm1, mm2

hlt