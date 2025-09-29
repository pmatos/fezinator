; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_03_8.asm
; FEX_SHA256: 8e42284fd4d607de233289d349bfede09b4074d8be82b157b6e110dabc2ed2bd
mov rbx, 0x00000002
mov rdi, 0x00000002
mov rdx, 0x80000000
mov rsi, 0x80000000
mov rcx, 32 ; Test wraparound with zero shift

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