; BITS: 64
; SOURCE: FEX Primary/Primary_AC.asm
; FEX_SHA256: bc9284bef9a85e41e586c25c32ab6438c32e45d4e1e970b8ef4d14d761affc06
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
lodsb
lodsb
lodsb
lodsb

lodsb
lodsb
lodsb
lodsb

hlt