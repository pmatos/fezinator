; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_03_6.asm
; FEX_SHA256: 22dc22068f51f65081a15c3e163a1563748cf43cd57add650506fa45270d3c15
mov rbx, 0x0000000000000001
mov rcx, 0x0000000000000001
mov rdx, 0x8000000000000000
mov rsi, 0x8000000000000000
mov r15, 1

stc
rcr rbx, 1
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr rcx, 1
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr rdx, 1
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr rsi, 1
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt