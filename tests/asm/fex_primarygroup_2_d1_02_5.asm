; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_02_5.asm
; FEX_SHA256: 49c8246bfa7ddd669c692f411ad1e4d1191a8438c6d2f33938bd8883517cf810
mov rbx, 0x00000001
mov rcx, 0x00000001
mov rdx, 0x80000000
mov rsi, 0x80000000
mov r15, 1

stc
rcl ebx, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcl ecx, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcl edx, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcl esi, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt