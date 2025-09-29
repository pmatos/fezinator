; BITS: 64
; SOURCE: FEX PrimaryGroup/4_FE_00.asm
; FEX_SHA256: 001a0302018983c84cfc9f659fac24e71ebf8d490ec772e42008d0107f3bacc7
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax

inc byte [rdx + 8 * 0 + 0]
mov rax, [rdx + 8 * 0]

hlt