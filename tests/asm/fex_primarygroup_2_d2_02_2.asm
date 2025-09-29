; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D2_02_2.asm
; FEX_SHA256: 8d53cbf5febc4264d492cee040ffe96d7dba70ec635865bc4322ad6c4419c77d
mov rbx, 0x01
mov rdi, 0x01
mov rdx, 0x80
mov rsi, 0x80
mov rcx, 1
mov r15, 1

stc
rcl bl, cl
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcl dil, cl
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcl dl, cl
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcl sil, cl
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt