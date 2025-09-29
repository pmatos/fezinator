; BITS: 64
; SOURCE: FEX TwoByte/0F_41.asm
; FEX_SHA256: 55e9b38bf4d134172f645d526fb749f15ff23f631f05e5a95d06c7e59c04757f
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
cmovno rax, [r15 + 8 * 1]
cmovo  rbx, [r15 + 8 * 0]

hlt