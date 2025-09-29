; BITS: 64
; SOURCE: FEX PrimaryGroup/4_FE_01.asm
; FEX_SHA256: bd3745dd9383ddd6a4e1dd774b3222b7e6876b799dd2ace1c23b6d4e1932a8ef
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax

dec byte [rdx + 8 * 0 + 0]
mov rax, [rdx + 8 * 0]

hlt