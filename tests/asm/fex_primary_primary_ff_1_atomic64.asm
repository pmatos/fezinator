; BITS: 64
; SOURCE: FEX Primary/Primary_FF_1_Atomic64.asm
; FEX_SHA256: ccf77aec7e82026aa2666ad4f64703ea2a4812e962031ef4a9104d919cc8a068
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

; Test 7 byte offset across 8byte boundary
lock dec qword [r15 + 8 * 0 + 7]

; Test 15 byte offset across 16byte boundary
lock dec qword [r15 + 8 * 0 + 15]

; Test 63 byte offset across cacheline boundary
lock dec qword [r15 + 8 * 0 + 63]

mov rax, qword [r15 + 8 * 0]
mov rbx, qword [r15 + 8 * 1]
mov rcx, qword [r15 + 8 * 2]
mov rdx, qword [r15 + 8 * 3]
mov rsi, qword [r15 + 8 * 7]
mov rdi, qword [r15 + 8 * 8]

hlt