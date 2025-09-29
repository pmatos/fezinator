; BITS: 64
; SOURCE: FEX TwoByte/0F_99.asm
; FEX_SHA256: 72fa653d477bcc5ef950cd74ff540034fd3b42061592a9d9f8a38ff6003fa50b
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0
setns al
sets  bl

hlt