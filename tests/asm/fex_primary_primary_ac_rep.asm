; BITS: 64
; SOURCE: FEX Primary/Primary_AC_REP.asm
; FEX_SHA256: 5f91e09b61d0dea77fa25fd0f637b0a10375ab903745df8335089aeadcaa9317
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rsi, [rdx + 8 * 0]

cld
mov rax, 0xFF
mov rcx, 8
rep lodsb

hlt