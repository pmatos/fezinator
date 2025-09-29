; BITS: 64
; SOURCE: FEX Primary/Primary_31_Atomic32.asm
; FEX_SHA256: 68d6760b8680e575aecdc7a78a602918d3fa1162fefd26da27a5bb7b14c5596d
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

mov rax, 1

; Test 3 byte offset across 4byte boundary
lock xor dword [r15 + 8 * 0 + 3], eax

; Test 7 byte offset across 8byte boundary
lock xor dword [r15 + 8 * 0 + 7], eax

; Test 15 byte offset across 16byte boundary
lock xor dword [r15 + 8 * 0 + 15], eax

; Test 63 byte offset across cacheline boundary
lock xor dword [r15 + 8 * 0 + 63], eax

mov rax, qword [r15 + 8 * 0]
mov rbx, qword [r15 + 8 * 1]
mov rcx, qword [r15 + 8 * 2]
mov rdx, qword [r15 + 8 * 3]
mov rsi, qword [r15 + 8 * 7]
mov rdi, qword [r15 + 8 * 8]

hlt