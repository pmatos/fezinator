; BITS: 64
; SOURCE: FEX TwoByte/0F_87.asm
; FEX_SHA256: 5e3d540465add72c33154b10ef9e7cf98bf593b394fac60512ab62a45e09b0f5
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jnbe .tgt_1
jbe .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt