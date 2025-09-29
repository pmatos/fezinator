; BITS: 64
; SOURCE: FEX TwoByte/0F_83.asm
; FEX_SHA256: 4592f3177f34a3faecad3eca186525355cd82325f70d221199190831f4325351
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jnc .tgt_1
jc .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt