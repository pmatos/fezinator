; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D2_02_3.asm
; FEX_SHA256: 55d8c5cc714293d86322eb373ff86976884f0375cc30c890e815fc64d31146c7
mov rbx, 0x02
mov rdi, 0x02
mov rdx, 0x80
mov rsi, 0x80
mov rcx, 8 ; Tests wrapping around features

stc
rcl bl, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcl dil, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcl dl, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcl sil, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt