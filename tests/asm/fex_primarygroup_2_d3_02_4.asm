; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_02_4.asm
; FEX_SHA256: 125021840571b51a3b38ee9cc6bb94fbcc75fc2ea668d78c960afb8652e24812
mov rbx, 0x00000001
mov rdi, 0x00000001
mov rdx, 0x40000000
mov rsi, 0x40000000
mov rcx, 34 ; Test wraparound

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