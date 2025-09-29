; BITS: 64
; SOURCE: FEX Primary/Primary_AE_REP.asm
; FEX_SHA256: 93f5986ad9e58e0e61fd263bdcf787eea7417ff3f7ebb56576b5f8ef2d85086e
mov rdx, 0xe0000000

mov rax, 0x4142434445466161
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 0]

cld
mov rax, 0x61
mov rcx, 8
cmp rax, 0x61

rep scasb

hlt