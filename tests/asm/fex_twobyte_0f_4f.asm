; BITS: 64
; SOURCE: FEX TwoByte/0F_4F.asm
; FEX_SHA256: 69e8a529d19fa35c806d854bfea869132a1c26a954ea175fe7aaa9b6cdb0fd18
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
cmovnle rax, [r15 + 8 * 1]
cmovle  rbx, [r15 + 8 * 0]

hlt