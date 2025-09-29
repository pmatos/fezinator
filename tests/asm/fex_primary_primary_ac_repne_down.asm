; BITS: 64
; SOURCE: FEX Primary/Primary_AC_REPNE_down.asm
; FEX_SHA256: c6ec7ac8bf1b19dd16f8c1645f87d0fda1e58f276b4cbb73c1335273c7677d36
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rsi, [rdx + 8 * 2]

std
mov rax, 0xFF
mov rcx, 8
repne lodsb

hlt