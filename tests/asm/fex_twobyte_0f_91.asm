; BITS: 64
; SOURCE: FEX TwoByte/0F_91.asm
; FEX_SHA256: 5488de71bea9223a3fd301d4742124334424af228759246c35e730f63a6cf106
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setno al
seto  bl

hlt