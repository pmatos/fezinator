; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_03_5.asm
; FEX_SHA256: 4e64c0702b3b1d49643b7f4fdd9c03a49041c084eddfe3c8c992e63d8e400353
mov rbx, 0x00000001
mov rcx, 0x00000001
mov rdx, 0x80000000
mov rsi, 0x80000000
mov r15, 1

stc
rcr ebx, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr ecx, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr edx, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr esi, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt