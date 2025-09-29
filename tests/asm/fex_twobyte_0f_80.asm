; BITS: 64
; SOURCE: FEX TwoByte/0F_80.asm
; FEX_SHA256: 0f9b4ca8405a29561f6ecb0d3daf6cad2db69fbc2ae4f7d8cc733f1de341d1c3
mov r15, 0xe0000000

mov r10, 0x80000000
mov r11, 0x1
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jo .tgt_1
jno .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt