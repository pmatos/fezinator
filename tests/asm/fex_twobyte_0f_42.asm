; BITS: 64
; SOURCE: FEX TwoByte/0F_42.asm
; FEX_SHA256: f41378e5577a2ede64596c0805d6338c36b68c44a8670b11c4328129c4d78858
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
cmovc  rax, [r15 + 8 * 1]
cmovnc rbx, [r15 + 8 * 0]

hlt