; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_03.asm
; FEX_SHA256: a6862a2b34101e0ab956009d5970db96f1e3f6d53dde048ff8bac397f09ec064
mov rbx, 0x02
mov rcx, 0x02
mov rdx, 0x80
mov rsi, 0x80

stc
rcr bl, 2
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr cl, 2
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr dl, 2
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr sil, 2
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt