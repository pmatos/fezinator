; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_02_2.asm
; FEX_SHA256: 5232cbce9c914a7155c916373d7bee35bb9f30766a41098e8ef7fd234e5d7d69
mov rbx, 0x01
mov rcx, 0x01
mov rdx, 0x40
mov rsi, 0x80
mov r15, 1

stc
rcl bl, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcl cl, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcl dl, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcl sil, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt