; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_02_3.asm
; FEX_SHA256: de4dbb71bb321dc5be57c981bcbb6021e0d1035ec033d97f3a08dd6cca775f7e
mov rbx, 0x0000000000000001
mov rdi, 0x0000000000000001
mov rdx, 0x4000000000000000
mov rsi, 0x4000000000000000
mov rcx, 2

stc
rcl rbx, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl rdi, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl rdx, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl rsi, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt