; BITS: 64
; SOURCE: FEX TwoByte/0F_81.asm
; FEX_SHA256: 3896f645687042156de5a1f5b200e8955358ed3a60f7e81ed00a880499ffcb54
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jno .tgt_1
jo .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt