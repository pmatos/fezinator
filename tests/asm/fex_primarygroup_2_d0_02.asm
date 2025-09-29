; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_02.asm
; FEX_SHA256: d7cd0f2f77006b558cab52b75889c8f12d0a3159f7541eb2485ce06f6c356291
mov rbx, 0x01
mov rcx, 0x01
mov rdx, 0x40
mov rsi, 0x80

stc
rcl bl, 1
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl cl, 1
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl dl, 1
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl sil, 1
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt