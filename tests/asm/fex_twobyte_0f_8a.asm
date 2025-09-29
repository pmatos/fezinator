; BITS: 64
; SOURCE: FEX TwoByte/0F_8A.asm
; FEX_SHA256: 858643a969b275d7a3785fdf0aa7057e16ffc8b0e39f62db2f9a537caa52126a
mov r15, 0xe0000000

mov r10, 0x4
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jp .tgt_1
jnp .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt