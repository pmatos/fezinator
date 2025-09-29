; BITS: 64
; SOURCE: FEX TwoByte/0F_4D.asm
; FEX_SHA256: 13fb67a0629b50f0b758e444ac249d510a6204c690baf0fe736191211ec5ec5d
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x2
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovnl rax, [r15 + 8 * 1]
cmovl  rbx, [r15 + 8 * 0]

hlt