; BITS: 64
; SOURCE: FEX TwoByte/0F_85.asm
; FEX_SHA256: d2193d0c9831bbf46f4aa55e7eef5a8480e3113001c84938cf571518e5c8d85b
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jnz .tgt_1
jz .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt