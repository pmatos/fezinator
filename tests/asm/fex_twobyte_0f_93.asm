; BITS: 64
; SOURCE: FEX TwoByte/0F_93.asm
; FEX_SHA256: a68676413dcb4ef23e47efe49c7e0a7dbd32870a08d57ecddf74dd42e6be851a
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setnc al
setc  bl

hlt