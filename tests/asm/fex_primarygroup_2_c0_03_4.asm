; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_03_4.asm
; FEX_SHA256: 01e38058e490db84dbdc5ee2975674874ab871392845836a175f027842569a66
mov rbx, 0x0000000000000002
mov rcx, 0x0000000000000002
mov rdx, 0x8000000000000000
mov rsi, 0x8000000000000000

stc
rcr rbx, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr rcx, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr rdx, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr rsi, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt