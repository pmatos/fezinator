; BITS: 64
; SOURCE: FEX TwoByte/0F_8D.asm
; FEX_SHA256: 6eae6c5f75af23776b08148bc64294cebfb6c1fb1634bbda829c697aa952d9a2
mov r15, 0xe0000000

mov r10, 0x2
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jnl .tgt_1
jl .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt