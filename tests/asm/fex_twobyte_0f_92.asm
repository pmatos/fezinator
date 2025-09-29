; BITS: 64
; SOURCE: FEX TwoByte/0F_92.asm
; FEX_SHA256: 08ebea501504d138d86a738b3cb79f358ec1d53a17032ab1b58392bab5042073
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setc  al
setnc bl

hlt