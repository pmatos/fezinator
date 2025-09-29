; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_03_3.asm
; FEX_SHA256: e91c48960bb20bfa93beb94f414e0a58e07d2548b996a0ab938d9e047e1f931c
mov rbx, 0x00000002
mov rcx, 0x00000002
mov rdx, 0x80000000
mov rsi, 0x80000000

stc
rcr ebx, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr ecx, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr edx, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr esi, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt