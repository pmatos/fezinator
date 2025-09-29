; BITS: 64
; SOURCE: FEX Primary/Primary_08.asm
; FEX_SHA256: eb29db64d0004c0ed6bc316b1470afc002df09a538cfd1eec37c24c81dee386a
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov rax, 0xD1
or byte  [r15 + 8 * 0 + 0], al
or word  [r15 + 8 * 0 + 2], ax
or dword [r15 + 8 * 0 + 4], eax
or qword [r15 + 8 * 1 + 0], rax

mov rbx, 0x71
mov rcx, 0x81
mov rdx, 0x91
mov rbp, 0xA1

or bl,  byte  [r15 + 8 * 2]
or cx,  word  [r15 + 8 * 2]
or edx, dword [r15 + 8 * 2]
or rbp, qword [r15 + 8 * 2]

mov rax, 0x01
or al, 0x80
mov rdi, rax

mov rax, 0x01
or ax, 0x8080
mov rsp, rax

mov rax, 0x01
or eax, 0x80808080
mov r8, rax

mov rax, 0x01
or rax, -1
mov r9, rax

mov r10, [r15 + 8 * 0]
mov r11, [r15 + 8 * 1]
mov r12, [r15 + 8 * 2]

hlt