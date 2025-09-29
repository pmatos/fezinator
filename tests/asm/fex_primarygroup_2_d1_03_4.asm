; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_03_4.asm
; FEX_SHA256: 5585cdec05dcab0dcf4051204f1abf54851c7e659fc45192edc0de484a65983d
mov rbx, 0x0001
mov rcx, 0x0001
mov rdx, 0x8000
mov rsi, 0x8000
mov r15, 1

stc
rcr bx, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr cx, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr dx, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr si, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt