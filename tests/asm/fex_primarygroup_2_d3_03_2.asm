; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_03_2.asm
; FEX_SHA256: c65b6c9dbbb136c605f799146e3c065804164739e9de17e144ad7c1ef2af9b7d
mov rbx, 0x00000002
mov rdi, 0x00000002
mov rdx, 0x80000000
mov rsi, 0x80000000
mov rcx, 2

stc
rcr ebx, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr edi, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr edx, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr esi, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt