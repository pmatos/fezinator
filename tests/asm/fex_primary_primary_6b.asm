; BITS: 64
; SOURCE: FEX Primary/Primary_6B.asm
; FEX_SHA256: 467ca2f6854a6a8b042223791016d0155a431ccaa6779a12353c2d36c5f09bf1
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov rax, 0x0
mov [r15 + 8 * 3], rax
mov [r15 + 8 * 4], rax

imul ax, word [r15 + 8 * 0 + 0], -128
mov word [r15 + 8 * 3 + 0], ax

imul eax, dword [r15 + 8 * 1 + 0], -128
mov dword [r15 + 8 * 4 + 0], eax

imul rax, qword [r15 + 8 * 2 + 0], -128
mov rsi, rax

mov rax, [r15 + 8 * 3]
mov rbx, [r15 + 8 * 4]

hlt