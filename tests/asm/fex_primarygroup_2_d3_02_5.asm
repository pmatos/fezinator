; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_02_5.asm
; FEX_SHA256: b5774e77dd222287828ab23e74c58e79d03fe10d286e3effdc66f71bea582cdf
mov rbx, 0x00000001
mov rdi, 0x00000001
mov rdx, 0x40000000
mov rsi, 0x40000000
mov rcx, 32 ; Test wraparound with zero shift

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