; BITS: 64
; SOURCE: FEX TwoByte/0F_90.asm
; FEX_SHA256: ccd8d28043115a5679f0976d8026c57312e4615b7e43927bffc1bf3ceaa679bf
mov r15, 0xe0000000

mov r10, 0x80000000
mov r11, 0x1
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0
seto al
setno bl

hlt