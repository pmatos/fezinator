; BITS: 64
; SOURCE: FEX Primary/Primary_99_2.asm
; FEX_SHA256: 1b4ebfc04a4a0f8c76c524e4ff25652e9c5464f6d08827bada6d7062a80c8dd3
; Positive 16bit
mov rax, 1
mov rdx, -1
cwd

mov r14, rax
mov r15, rdx

; Positive 32bit

mov rax, 1
mov rdx, -1
cdq

mov r12, rax
mov r13, rdx

; Positive 64bit

mov rax, 1
mov rdx, -1
cqo

mov r10, rax
mov r11, rdx

; Negative 16bit
mov rax, 0xFFFF
mov rdx, 0
cwd

mov r8, rax
mov r9, rdx

; Negative 32bit
mov rax, 0xFFFFFFFF
mov rdx, 0
cdq

mov rdi, rax
mov rsp, rdx

; Negative 64bit
mov rax, -1
mov rdx, 0
cqo

mov rbp, rax
mov rsi, rdx


hlt