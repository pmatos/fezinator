; BITS: 64
; SOURCE: FEX TwoByte/0F_43.asm
; FEX_SHA256: 1c244a81781684861f9794bc7f4b2896d774493aeec5fa9743cf3c48f60a6a84
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
cmovnc rax, [r15 + 8 * 1]
cmovc  rbx, [r15 + 8 * 0]

hlt