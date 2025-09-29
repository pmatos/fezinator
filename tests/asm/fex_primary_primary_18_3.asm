; BITS: 64
; SOURCE: FEX Primary/Primary_18_3.asm
; FEX_SHA256: 117e03e4bb0cca6939468803723251c92081ebe70b9d1b54c3a5e1118d332a86
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov rax, 0xD1
clc
lock sbb byte  [r15 + 8 * 0 + 0], al
clc
lock sbb word  [r15 + 8 * 0 + 2], ax
clc
lock sbb dword [r15 + 8 * 0 + 4], eax
clc
lock sbb qword [r15 + 8 * 1 + 0], rax

mov rbx, 0x71
mov rcx, 0x81
mov rdx, 0x91
mov rbp, 0xA1

clc
sbb bl,  byte  [r15 + 8 * 2]
clc
sbb cx,  word  [r15 + 8 * 2]
clc
sbb edx, dword [r15 + 8 * 2]
clc
sbb rbp, qword [r15 + 8 * 2]

mov rax, 0x01
clc
sbb al, 0x80
mov rdi, rax

mov rax, 0x01
clc
sbb ax, 0x8080
mov rsp, rax

mov rax, 0x01
clc
sbb eax, 0x80808080
mov r8, rax

mov rax, 0x01
clc
sbb rax, -1
mov r9, rax

mov r10, [r15 + 8 * 0]
mov r11, [r15 + 8 * 1]
mov r12, [r15 + 8 * 2]

hlt