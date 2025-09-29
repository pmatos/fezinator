; BITS: 64
; SOURCE: FEX TwoByte/0F_9A.asm
; FEX_SHA256: 83b1dade58a870e1bec7cae729a4c2014a6ebe0686299c80d1a8688f46f97c03
mov r15, 0xe0000000

mov r10, 0x4
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setp al
setnp  bl

hlt