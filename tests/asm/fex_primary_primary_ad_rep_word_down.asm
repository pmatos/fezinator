; BITS: 64
; SOURCE: FEX Primary/Primary_AD_REP_word_down.asm
; FEX_SHA256: 48b932a96fda9d68d35ac41acfc265f427fdc3c145da4ce4859e600cd9c94862
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
rep lodsw

hlt