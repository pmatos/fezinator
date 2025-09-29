; BITS: 64
; SOURCE: FEX TwoByte/0F_86.asm
; FEX_SHA256: fc7f87a558ee5579e0114379bae34f904bd9fd624469545c4ceaca9c6a8f1d42
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jbe .tgt_1
jnbe .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt