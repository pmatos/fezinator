; BITS: 64
; SOURCE: FEX TwoByte/0F_49.asm
; FEX_SHA256: 426fd92619ac69a5a636de12a8478fc77254049912289db54f6d8eb7a75ab1e7
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x1
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovns rax, [r15 + 8 * 1]
cmovs  rbx, [r15 + 8 * 0]

hlt