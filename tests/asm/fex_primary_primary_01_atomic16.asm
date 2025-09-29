; BITS: 64
; SOURCE: FEX Primary/Primary_01_Atomic16.asm
; FEX_SHA256: cc538e6f04b3955b8994d445867a476f23f0dc31d53c10fe15de08cb8820ae72
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

; Test 1 byte offset within 4byte boundary
lock add word [r15 + 8 * 0 + 1], ax

; Test 3 byte offset across 4byte boundary
lock add word [r15 + 8 * 0 + 3], ax

; Test 7 byte offset across 8byte boundary
lock add word [r15 + 8 * 0 + 7], ax

; Test 15 byte offset across 16byte boundary
lock add word [r15 + 8 * 0 + 15], ax

; Test 63 byte offset across cacheline boundary
lock add word [r15 + 8 * 0 + 63], ax

mov rax, qword [r15 + 8 * 0]
mov rbx, qword [r15 + 8 * 1]
mov rcx, qword [r15 + 8 * 2]
mov rdx, qword [r15 + 8 * 3]
mov rsi, qword [r15 + 8 * 7]
mov rdi, qword [r15 + 8 * 8]

hlt