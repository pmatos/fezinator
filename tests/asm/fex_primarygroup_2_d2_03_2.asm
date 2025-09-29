; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D2_03_2.asm
; FEX_SHA256: bcfeda46891c8a179fa158af8a5d759f6bcf5addbe6d22b21c149ab58cf19898
mov rbx, 0x01
mov rdi, 0x01
mov rdx, 0x80
mov rsi, 0x80
mov r15, 1
mov rcx, 1

stc
rcr bl, cl
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr dil, cl
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr dl, cl
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr sil, cl
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt