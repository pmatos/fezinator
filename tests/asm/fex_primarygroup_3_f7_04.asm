; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_04.asm
; FEX_SHA256: 1c8b4ecdea9f59f822bce9a68b3f54e434e2ca1820b501ab752d1b3cd6e24174
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov ax, 0x7172
mul word [r15 + 8 * 0 + 0]
mov word [r15 + 8 * 0 + 0], ax
mov word [r15 + 8 * 0 + 2], dx

mov eax, 0x71727374
mul dword [r15 + 8 * 1 + 0]
mov dword [r15 + 8 * 1 + 0], eax
mov dword [r15 + 8 * 1 + 4], edx

mov rax, 0x7172737475767778
mul qword [r15 + 8 * 2 + 0]
mov rsi, rax
mov rsp, rdx

; Ensure zext handling is correct
; 16bit
mov rax, 0xFFFFFFFFFFFF0002
mov rbx, 0xFFFFFFFFFFFF0002
mul bx
mov rcx, rax

; 32bit
mov rax, 0xFFFFFFFF00000002
mov rbx, 0xFFFFFFFF00000002
mul ebx
mov rdx, rax

mov rax, [r15 + 8 * 0]
mov rbx, [r15 + 8 * 1]

hlt