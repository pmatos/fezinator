; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_02_4.asm
; FEX_SHA256: b6e38d0ed15d57b4ce660ef35e75ea4be5aef8fd7ffee3e112f1ff70722b16ce
mov rbx, 0x0000000000000001
mov rcx, 0x0000000000000001
mov rdx, 0x4000000000000000
mov rsi, 0x4000000000000000

stc
rcl rbx, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl rcx, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl rdx, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl rsi, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt