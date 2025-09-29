; BITS: 64
; SOURCE: FEX TwoByte/0F_84.asm
; FEX_SHA256: d0b05e9816bae4af09d99c0d1c99c23c7f421503641dd5e6831b5bbd09f856dc
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jz .tgt_1
jnz .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt