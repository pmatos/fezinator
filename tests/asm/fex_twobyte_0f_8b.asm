; BITS: 64
; SOURCE: FEX TwoByte/0F_8B.asm
; FEX_SHA256: d90897f75c14cde1a76058ed414d5896f7cfcce68f0f1c277ca70b50b20aaa1c
mov r15, 0xe0000000

mov r10, 0x3
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jnp .tgt_1
jp .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt