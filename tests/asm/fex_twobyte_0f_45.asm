; BITS: 64
; SOURCE: FEX TwoByte/0F_45.asm
; FEX_SHA256: 5517ae23ea5112076d4d2e0bc9f347d484ee077a368f14dc24ef612f1a6bf5d8
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x2
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovnz rax, [r15 + 8 * 1]
cmovz  rbx, [r15 + 8 * 0]

hlt