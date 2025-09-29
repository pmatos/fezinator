; BITS: 64
; SOURCE: FEX TwoByte/0F_4E.asm
; FEX_SHA256: 1801f8cfdbff7d2f1e58002550d0a826ef2e28c8c8491f376f503c82b4c4ad84
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovle  rax, [r15 + 8 * 1]
cmovnle rbx, [r15 + 8 * 0]

hlt