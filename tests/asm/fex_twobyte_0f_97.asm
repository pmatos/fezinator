; BITS: 64
; SOURCE: FEX TwoByte/0F_97.asm
; FEX_SHA256: e38a01d84bca1501d9c9f92b243693e17ea513760e1b5ec5b8548218ad04eceb
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setnbe al
setbe  bl

hlt