; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_03_2.asm
; FEX_SHA256: e010c0d43fcc47548a7dc7d5ffea9a035c71aefb77694f0fbb7bcb2413c08066
mov rbx, 0x0002
mov rcx, 0x0002
mov rdx, 0x8000
mov rsi, 0x8000

stc
rcr bx, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr cx, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr dx, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr si, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt