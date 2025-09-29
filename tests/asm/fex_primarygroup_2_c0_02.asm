; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_02.asm
; FEX_SHA256: e898d3c997c5016880e33964666247bafc541e956f3ede44172926cea316fb8d
mov rbx, 0x01
mov rcx, 0x01
mov rdx, 0x40
mov rsi, 0x40

stc
rcl bl, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl cl, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl dl, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl sil, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt