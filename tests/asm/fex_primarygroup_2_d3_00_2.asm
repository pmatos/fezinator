; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_00_2.asm
; FEX_SHA256: 5ea79e700b6a4fb7d429b481a5015d236093ae50ae4f3ef0a4e4a7f26a7836be
mov r15, 1

; Should all set carry
;8bit
mov rax, 0x01

mov cl, 8
rol al, cl

mov r14, 0
cmovc r14, r15

; 16bit
mov rax, 0x0001

mov cl, 16
rol ax, cl

mov r13, 0
cmovc r13, r15

; 32bit
mov rax, 0x00000002

mov cl, 31
rol eax, cl

mov r12, 0
cmovc r12, r15

; 64bit
mov rax, 0x0000000000000002

mov cl, 63
rol rax, cl

mov r11, 0
cmovc r11, r15

; Shouldn't set carry

;8bit
clc
mov rax, 0x01

mov cl, 0
rol al, cl

mov r10, 0
cmovc r10, r15

; 16bit
clc
mov rax, 0x0001

mov cl, 0
rol ax, cl

mov r9, 0
cmovc r9, r15

; 32bit
clc
mov rax, 0x00000001

mov cl, 0
rol eax, cl

mov r8, 0
cmovc r8, r15

; 64bit
clc
mov rax, 0x0000000000000001

mov cl, 0
rol rax, cl

mov rsp, 0
cmovc rsp, r15

hlt