; BITS: 64
; SOURCE: FEX TwoByte/0F_88.asm
; FEX_SHA256: 6c4aebf7a1299a6ddb153bd14604056b895bf4e92f0ef18d70b9f3f7db5a6d4b
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

js .tgt_1
jns .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt