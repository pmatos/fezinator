; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_03_3.asm
; FEX_SHA256: 5483fc69999d843bac9646a939545a252a9397555e9a338eef54b8bc7f5c60f3
mov rbx, 0x0000000000000001
mov rcx, 0x0000000000000001
mov rdx, 0x8000000000000000
mov rsi, 0x8000000000000000

stc
rcr rbx, 1
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr rcx, 1
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr rdx, 1
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr rsi, 1
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt