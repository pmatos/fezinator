; BITS: 64
; SOURCE: FEX TwoByte/0F_4C.asm
; FEX_SHA256: 2cb7bd2a9d2a7c42c9fc6dc5257d9ec774c05a6cb5351aaa0de946e8eed7649e
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
cmovl  rax, [r15 + 8 * 1]
cmovnl rbx, [r15 + 8 * 0]

hlt