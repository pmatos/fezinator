; BITS: 64
; SOURCE: FEX Primary/Primary_A5_qword_REP.asm
; FEX_SHA256: adc92b579d1fd532b045a1f9bafddc7aaae932e1e19a38f75c1313b66ab3aa2c
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax
mov [rdx + 8 * 4], rax

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 2
rep movsq ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rbx, [rdx + 8 * 3]
mov rcx, [rdx + 8 * 4]
hlt