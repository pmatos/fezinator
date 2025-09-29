; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_02.asm
; FEX_SHA256: 712cec78fbc2370ab137a5b8f492a0612423b8f80425821e5ec954007a18edb1
mov rbx, 0x0001
mov rdi, 0x0001
mov rdx, 0x4000
mov rsi, 0x4000
mov rcx, 2

stc
rcl bx, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl di, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl dx, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl si, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt