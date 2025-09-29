; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_02_2.asm
; FEX_SHA256: c2a7c7ae460552bd7ce2169954d37e0eedfd3c2ab5693f66cfe4c52db116c8b6
mov rbx, 0x00000001
mov rcx, 0x00000001
mov rdx, 0x80000000
mov rsi, 0x80000000

stc
rcl ebx, 1
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl ecx, 1
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl edx, 1
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl esi, 1
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt