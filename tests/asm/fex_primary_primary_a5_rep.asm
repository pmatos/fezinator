; BITS: 64
; SOURCE: FEX Primary/Primary_A5_REP.asm
; FEX_SHA256: b81ca0288343c2cd362b06ab0d7c7141a9c8a03201ed6a04c4abc3730543cfa4
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
mov rcx, 4
rep movsw ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt