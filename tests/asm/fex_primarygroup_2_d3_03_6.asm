; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_03_6.asm
; FEX_SHA256: 22df35c30b4e7b3b72a1e8f6cbbec618bf7edcc705632d024db1f2f7456c3173
mov rbx, 0x0000000000000001
mov rdi, 0x0000000000000001
mov rdx, 0x8000000000000000
mov rsi, 0x8000000000000000
mov r15, 1
mov rcx, 1

stc
rcr rbx, cl
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr rdi, cl
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr rdx, cl
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr rsi, cl
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt