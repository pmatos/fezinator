; BITS: 64
; SOURCE: FEX TwoByte/0F_98.asm
; FEX_SHA256: be9ecf48ba721894c530e09c357ef35610da0955f26088655eea103104f92689
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0
sets  al
setns bl

hlt