; BITS: 64
; SOURCE: FEX Primary/Primary_87_Atomic64.asm
; FEX_SHA256: ba449da4fc662b41e00bd284d4c7ee74c2a5e3793a29ffc8d9adc0b3f744e3f4
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov [r15 + 8 * 1], rax
mov [r15 + 8 * 2], rax
mov [r15 + 8 * 3], rax
mov [r15 + 8 * 4], rax
mov [r15 + 8 * 5], rax
mov [r15 + 8 * 6], rax
mov [r15 + 8 * 7], rax
mov [r15 + 8 * 8], rax
mov [r15 + 8 * 9], rax

; Test 7 byte offset across 8byte boundary
mov rax, 1
lock xchg qword [r15 + 8 * 0 + 7], rax
mov r13, rax

; Test 15 byte offset across 16byte boundary
mov rax, 1
lock xchg qword [r15 + 8 * 0 + 15], rax
mov r12, rax

; Test 63 byte offset across cacheline boundary
mov rax, 1
lock xchg qword [r15 + 8 * 0 + 63], rax
mov r11, rax

mov rax, qword [r15 + 8 * 0]
mov rbx, qword [r15 + 8 * 1]
mov rcx, qword [r15 + 8 * 2]
mov rdx, qword [r15 + 8 * 3]
mov rsi, qword [r15 + 8 * 7]
mov rdi, qword [r15 + 8 * 8]

hlt