; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_02_4.asm
; FEX_SHA256: b24e8385f7fb7ea3938e71d88923c79dd139398a740895ff3d40561708d24df7
mov rbx, 0x0001
mov rcx, 0x0001
mov rdx, 0x8000
mov rsi, 0x8000
mov r15, 1

stc
rcl bx, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcl cx, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcl dx, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcl si, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt