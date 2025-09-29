; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_02_3.asm
; FEX_SHA256: 27e92de3bb43f2f1155de2b4820f0cc51638c556e0ee6da55a42e7a3302e0c01
mov rbx, 0x00000001
mov rcx, 0x00000001
mov rdx, 0x40000000
mov rsi, 0x40000000

stc
rcl ebx, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl ecx, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl edx, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl esi, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt