; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D2_02.asm
; FEX_SHA256: 3aec219f6e73380e4a74d691e3bcf95c5ca2fcf959dc13a5f4bc60207a85a38e
mov rbx, 0x01
mov rdi, 0x01
mov rdx, 0x40
mov rsi, 0x40
mov rcx, 2

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