; BITS: 64
; SOURCE: FEX Primary/Primary_FD.asm
; FEX_SHA256: d2e8372032a60257eaee7e3a7724228961233e590f7dc8a3eba142e258d8fb30
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

lea rdi, [rdx + 8 * 1]

mov al, 0x0
std
scasb

hlt