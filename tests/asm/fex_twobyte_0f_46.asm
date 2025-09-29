; BITS: 64
; SOURCE: FEX TwoByte/0F_46.asm
; FEX_SHA256: 4f04d8c5431cf017e4f71cf5af52470fb7803738ffcfb717d7676afaeba331a0
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
cmovbe  rax, [r15 + 8 * 1]
cmovnbe rbx, [r15 + 8 * 0]

hlt