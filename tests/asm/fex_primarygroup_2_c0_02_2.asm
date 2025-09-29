; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_02_2.asm
; FEX_SHA256: 1b2264318dd8b9f4387d51ed1bcabc985256589e4cab919fd82da675674d624e
mov rbx, 0x0001
mov rcx, 0x0001
mov rdx, 0x4000
mov rsi, 0x4000

stc
rcl bx, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl cx, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl dx, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl si, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt