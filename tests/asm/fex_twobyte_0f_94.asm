; BITS: 64
; SOURCE: FEX TwoByte/0F_94.asm
; FEX_SHA256: 625894e8c623852d5d19df493ee8d42c5146096499459f1e932324315ce1a3b6
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setz  al
setnz bl

hlt