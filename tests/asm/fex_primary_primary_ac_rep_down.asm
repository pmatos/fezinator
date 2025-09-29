; BITS: 64
; SOURCE: FEX Primary/Primary_AC_REP_down.asm
; FEX_SHA256: 04d303c41e3a7ed19d3ea44254ff5a3fe83915050bd864e2da44bd9d46e5d809
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
rep lodsb

hlt