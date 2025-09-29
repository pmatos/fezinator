; BITS: 64
; SOURCE: FEX TwoByte/0F_95.asm
; FEX_SHA256: 096116192f8af9174949e39c73430e50c2e2414e9fc370d9008c8fbd5125f02d
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setnz al
setz  bl

hlt