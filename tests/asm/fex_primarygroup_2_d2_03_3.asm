; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D2_03_3.asm
; FEX_SHA256: fd71ca5d032b69d2731400cbe3fa0dffe9e9f41afe765ddc353c6af5f4ad8502
mov rbx, 0x02
mov rdi, 0x02
mov rdx, 0x80
mov rsi, 0x80
mov rcx, 8 ; Tests wrapping around features

stc
rcr bl, cl
lahf
mov r8w, ax
shr r8, 8
and r8, 1 ; We only care about carry flag here

clc
rcr dil, cl
lahf
mov r9w, ax
shr r9, 8
and r9, 1 ; We only care about carry flag here

stc
rcr dl, cl
lahf
mov r10w, ax
shr r10, 8
and r10, 1 ; We only care about carry flag here

clc
rcr sil, cl
lahf
mov r11w, ax
shr r11, 8
and r11, 1 ; We only care about carry flag here

hlt