; BITS: 64
; SOURCE: FEX TwoByte/0F_4A.asm
; FEX_SHA256: aacefdc6e3e7ec6e4018a5da412072415e6ec7f169f5e23960697ba591b43217
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x4
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovp  rax, [r15 + 8 * 1]
cmovnp rbx, [r15 + 8 * 0]

hlt