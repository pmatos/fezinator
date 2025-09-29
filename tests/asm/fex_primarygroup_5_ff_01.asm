; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_01.asm
; FEX_SHA256: af9a4b0959c51050bacbf886a0aed22f03600a222f9691380f88b985c68e4e2c
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

dec  word [r15 + 8 * 0 + 0]
dec dword [r15 + 8 * 1 + 0]
dec qword [r15 + 8 * 2 + 0]

mov rax, [r15 + 8 * 0]
mov rbx, [r15 + 8 * 1]
mov rcx, [r15 + 8 * 2]

hlt