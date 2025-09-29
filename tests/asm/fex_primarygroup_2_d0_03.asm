; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_03.asm
; FEX_SHA256: 20528e8826e91cace373a4f124b4d01d8989b288e78892568d5114dde713a7be
mov rbx, 0x01
mov rcx, 0x01
mov rdx, 0x80
mov rsi, 0x80

stc
rcr bl, 1
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr cl, 1
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr dl, 1
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr sil, 1
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt