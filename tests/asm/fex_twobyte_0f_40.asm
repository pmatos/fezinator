; BITS: 64
; SOURCE: FEX TwoByte/0F_40.asm
; FEX_SHA256: ff52697276f05822fa4ba90b3390a62e6755238c4c33ad2fc639ca9de6c32351
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x80000000
mov r11, 0x1
mov r12, 0x2

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovo  rax, [r15 + 8 * 1]
cmovno rbx, [r15 + 8 * 0]

hlt