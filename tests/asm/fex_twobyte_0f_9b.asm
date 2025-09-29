; BITS: 64
; SOURCE: FEX TwoByte/0F_9B.asm
; FEX_SHA256: 28b7930bb3891b4746230e47e71a27991744358ebabd7929d30544c57601a607
mov r15, 0xe0000000

mov r10, 0x3
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setnp al
setp  bl

hlt