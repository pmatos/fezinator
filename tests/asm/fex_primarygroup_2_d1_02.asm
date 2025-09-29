; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_02.asm
; FEX_SHA256: 7e1b4cb4c3a75b9f2a1dd32417a0c40866cff64b6d96c4f9c38ec19358906d5f
mov rbx, 0x0001
mov rcx, 0x0001
mov rdx, 0x8000
mov rsi, 0x8000

stc
rcl bx, 1
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl cx, 1
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl dx, 1
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl si, 1
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt