; BITS: 64
; SOURCE: FEX TwoByte/0F_82.asm
; FEX_SHA256: 1c4c6f9f90968d8b1f15a793691ffa1f44e1189f59b5ad19039196e58e986b52
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jc .tgt_1
jnc .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt