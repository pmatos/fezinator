; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_02_2.asm
; FEX_SHA256: a6d3d5fc7c745783b2e163a57313101e258d3ceb6cfbc5bd59ac8ef3406ce764
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

lock not byte [rdx + 8 * 0 + 1]

mov rax, [rdx + 8 * 0]

hlt