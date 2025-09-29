; BITS: 64
; SOURCE: FEX Primary/Primary_A4_REP_many.asm
; FEX_SHA256: 745e816dbebcad4a7a1e0e50bd552d8c581272edc86fb442202384c0989aa7f9
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
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
rep movsb ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt