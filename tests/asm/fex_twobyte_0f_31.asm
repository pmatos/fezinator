; BITS: 64
; SOURCE: FEX TwoByte/0F_31.asm
; FEX_SHA256: 5c964c9b562251a5f76effdd0d8715b76cdca8fd0521408e27a17469285bf11e
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax

rdtsc
shl rdx, 32
or rax, rdx
cmp rax, 0
setne [r15 + 8 * 0]
mov rax, [r15 + 8 * 0]

hlt