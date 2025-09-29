; BITS: 64
; SOURCE: FEX TwoByte/0F_47.asm
; FEX_SHA256: 92eebf49e3c8766863d425585f0138e560d7df1da55e747c4c5c74de4fbf922a
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
cmovnbe rax, [r15 + 8 * 1]
cmovbe  rbx, [r15 + 8 * 0]

hlt