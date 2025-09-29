; BITS: 64
; SOURCE: FEX Primary/Primary_20.asm
; FEX_SHA256: 5f1c9a29b65cbbd4c6d68b13aaca39df64d1bb67c6a70ca45b8aeb54179433d7
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov rax, 0xD1
and byte  [r15 + 8 * 0 + 0], al
and word  [r15 + 8 * 0 + 2], ax
and dword [r15 + 8 * 0 + 4], eax
and qword [r15 + 8 * 1 + 0], rax

mov rbx, 0x71
mov rcx, 0x81
mov rdx, 0x91
mov rbp, 0xA1

and bl,  byte  [r15 + 8 * 2]
and cx,  word  [r15 + 8 * 2]
and edx, dword [r15 + 8 * 2]
and rbp, qword [r15 + 8 * 2]

mov rax, 0x01
and al, 0x80
mov rdi, rax

mov rax, 0x01
and ax, 0x8080
mov rsp, rax

mov rax, 0x01
and eax, 0x80808080
mov r8, rax

mov rax, 0x01
and rax, -1
mov r9, rax

mov r10, [r15 + 8 * 0]
mov r11, [r15 + 8 * 1]
mov r12, [r15 + 8 * 2]

hlt