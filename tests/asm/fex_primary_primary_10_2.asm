; BITS: 64
; SOURCE: FEX Primary/Primary_10_2.asm
; FEX_SHA256: 55a0b2c9f05509fe6508403fcc99c3afc8088e51b94fe6f9c1e6d63683050901
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov rax, 0xD1
stc
adc byte  [r15 + 8 * 0 + 0], al
stc
adc word  [r15 + 8 * 0 + 2], ax
stc
adc dword [r15 + 8 * 0 + 4], eax
stc
adc qword [r15 + 8 * 1 + 0], rax

mov rbx, 0x71
mov rcx, 0x81
mov rdx, 0x91
mov rbp, 0xA1

stc
adc bl,  byte  [r15 + 8 * 2]
stc
adc cx,  word  [r15 + 8 * 2]
stc
adc edx, dword [r15 + 8 * 2]
stc
adc rbp, qword [r15 + 8 * 2]

mov rax, 0x01
stc
adc al, 0x80
mov rdi, rax

mov rax, 0x01
stc
adc ax, 0x8080
mov rsp, rax

mov rax, 0x01
stc
adc eax, 0x80808080
mov r8, rax

mov rax, 0x01
stc
adc rax, -1
mov r9, rax

mov r10, [r15 + 8 * 0]
mov r11, [r15 + 8 * 1]
mov r12, [r15 + 8 * 2]

hlt