; BITS: 64
; SOURCE: FEX TwoByte/0F_8F.asm
; FEX_SHA256: 58c0494eb085beb9d8c8322003b5a03fabe3c005f43c675ff02c4a8afb6875b5
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jnle .tgt_1
jle .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt