; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_00.asm
; FEX_SHA256: a818aedd46c60a12ba854c1f34fbe3223441850453f7a91cbccb630974be1519
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

rol byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt