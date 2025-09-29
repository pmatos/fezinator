; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_02_6.asm
; FEX_SHA256: f45ad8ac3a2210fb85f34b2628201d677a53e38d8458ca3518c6a06fed8f30d4
mov rbx, 0x0000000000000001
mov rcx, 0x0000000000000001
mov rdx, 0x8000000000000000
mov rsi, 0x8000000000000000
mov r15, 1

stc
rcl rbx, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcl rcx, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcl rdx, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcl rsi, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt