; BITS: 64
; SOURCE: FEX Primary/Primary_A4_REPNE_many.asm
; FEX_SHA256: 5aa8a71fedda353948896031ff3e8cd8addac1bb581b38f535afb5f1cacede4d
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
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 8
repne movsb ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt