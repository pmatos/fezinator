; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_03.asm
; FEX_SHA256: c4cfa5e1245c39ca5b4989bce1c36b6351dbbbf57c4c38234694c0956fe4b21e
mov rbx, 0x0002
mov rdi, 0x0002
mov rdx, 0x8000
mov rsi, 0x8000
mov rcx, 2

stc
rcr bx, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr di, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr dx, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr si, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt