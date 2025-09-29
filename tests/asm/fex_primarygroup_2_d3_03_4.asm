; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_03_4.asm
; FEX_SHA256: d4c786697c94d3bc5076e69ab134cd4b4aad8e1e8343c031d7f4a71c532faf20
mov rbx, 0x0001
mov rdi, 0x0001
mov rdx, 0x8000
mov rsi, 0x8000
mov r15, 1
mov rcx, 1

stc
rcr bx, cl
mov r8, 0
cmovo r8, r15 ; We only care about OF here

clc
rcr di, cl
mov r9, 0
cmovo r9, r15 ; We only care about OF here

stc
rcr dx, cl
mov r10, 0
cmovo r10, r15 ; We only care about OF here

clc
rcr si, cl
mov r11, 0
cmovo r11, r15 ; We only care about OF here

hlt