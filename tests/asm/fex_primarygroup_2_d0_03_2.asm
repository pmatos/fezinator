; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_03_2.asm
; FEX_SHA256: 11629ef2f18ecf8e4e23324ffad250cbcb877ab9a18b14ccafb88120c238e73f
mov rbx, 0x01
mov rcx, 0x01
mov rdx, 0x80
mov rsi, 0x80
mov r15, 1

stc
rcr bl, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr cl, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr dl, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr sil, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt