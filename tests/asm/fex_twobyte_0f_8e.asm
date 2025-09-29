; BITS: 64
; SOURCE: FEX TwoByte/0F_8E.asm
; FEX_SHA256: ab2c3858db08bcf672775bb921b14a707335d65c89973328f47535c91ee171df
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jle .tgt_1
jnle .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt