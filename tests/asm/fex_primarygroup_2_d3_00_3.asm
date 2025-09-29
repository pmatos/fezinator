; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_00_3.asm
; FEX_SHA256: 7b18c86baa8f3a301859bdd4ef53c1971edaa33f3b0501d0a19cc0ee8c8bc551
mov r15, 1

; Should all set OF
;8bit
mov rax, 0x40

mov cl, 1
rol al, cl

mov r14, 0
cmovo r14, r15

; 16bit
mov rax, 0x4000

mov cl, 1
rol ax, cl

mov r13, 0
cmovo r13, r15

; 32bit
mov rax, 0x40000000

mov cl, 1
rol eax, cl

mov r12, 0
cmovo r12, r15

; 64bit
mov rax, 0x4000000000000000

mov cl, 1
rol rax, cl

mov r11, 0
cmovo r11, r15

; Let's clear OF really quick
mov rax, 0
rol rax, 1

; Shouldn't set OF

;8bit
clc
mov rax, 0x80

mov cl, 0
rol al, cl

mov r10, 0
cmovo r10, r15

; 16bit
clc
mov rax, 0x8000

mov cl, 0
rol ax, cl

mov r9, 0
cmovo r9, r15

; 32bit
clc
mov rax, 0x80000000

mov cl, 0
rol eax, cl

mov r8, 0
cmovo r8, r15

; 64bit
clc
mov rax, 0x8000000000000000

mov cl, 0
rol rax, cl

mov rsp, 0
cmovo rsp, r15

hlt