; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_02_2.asm
; FEX_SHA256: e55359c1f5c0b396806fafe53a135f28bbc9fcdac348b286945a8848888cd61b
mov rbx, 0x00000001
mov rdi, 0x00000001
mov rdx, 0x40000000
mov rsi, 0x40000000
mov rcx, 2

stc
rcl ebx, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl edi, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl edx, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl esi, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt