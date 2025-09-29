; BITS: 64
; SOURCE: FEX Primary/Primary_A4.asm
; FEX_SHA256: 7643906b23decc538d2a9dd304eff9b53074f123767d38afa71eb161b283817e
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
movsb ; rdi <- rsi
movsb
movsb
movsb

movsb
movsb
movsb
movsb

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt