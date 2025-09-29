; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_03_5.asm
; FEX_SHA256: 3b6592d528626390b134933dc0f01b2c42e051e6673785698c51360b499e4b26
mov rbx, 0x00000001
mov rdi, 0x00000001
mov rdx, 0x80000000
mov rsi, 0x80000000
mov r15, 1
mov rcx, 1

stc
rcr ebx, cl
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr edi, cl
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr edx, cl
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr esi, cl
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt