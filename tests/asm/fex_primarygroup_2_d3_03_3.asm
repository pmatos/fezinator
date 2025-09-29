; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_03_3.asm
; FEX_SHA256: de1d05c15cdbcdbbce39b8c744c9d949349c9eca1a1e82f97ee676ffdbd05791
mov rbx, 0x0000000000000002
mov rdi, 0x0000000000000002
mov rdx, 0x8000000000000000
mov rsi, 0x8000000000000000
mov rcx, 2

stc
rcr rbx, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr rdi, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr rdx, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr rsi, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt