; BITS: 64
; SOURCE: FEX TwoByte/0F_2C.asm
; FEX_SHA256: 1ea642648ec464adfcd6d89919432180a2a196663a739c79feaa414397f4043b
mov rdx, 0xe0000000

mov rax, 0x3f80000040000000
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

movq mm0, [rdx + 8 * 2]
movaps xmm0, [rdx + 8 * 0]

cvttps2pi mm0, xmm0

hlt