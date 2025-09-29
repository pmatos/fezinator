; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_04.asm
; FEX_SHA256: eeb7b2e1f022d6d594d99923511f635f5530d4eec103c89ee2335587dc3a5e63
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

and byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt