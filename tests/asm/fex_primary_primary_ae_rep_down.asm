; BITS: 64
; SOURCE: FEX Primary/Primary_AE_REP_down.asm
; FEX_SHA256: f120f51ea38cb40fdea1064b3cf22cbe5c4396382afb75e4775d5a400dc73758
mov rdx, 0xe0000000

mov rax, 0x4142434445466161
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 2]

std
mov rax, 0x61
mov rcx, 8
cmp rax, 0x61

rep scasb

hlt