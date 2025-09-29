; BITS: 64
; SOURCE: FEX TwoByte/0F_44.asm
; FEX_SHA256: 426e26150525e4886b9faf35b180abc65701fb0409690a8d0c3078030424e838
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x1
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovz  rax, [r15 + 8 * 1]
cmovnz rbx, [r15 + 8 * 0]

hlt