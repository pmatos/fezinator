; BITS: 64
; SOURCE: FEX TwoByte/0F_96.asm
; FEX_SHA256: 4d2ac60a6e5b6738d0f3667b074d6fb74e2e04aa436e08ce2cbdf63b514f7a24
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setbe  al
setnbe bl

hlt