; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_05.asm
; FEX_SHA256: b19b7145f4e87e29a341567e588b94cd797fe3fa15b78c68c9a9c0f39eef5879
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov ax, -128
imul word [r15 + 8 * 0 + 0]
mov word [r15 + 8 * 0 + 0], ax
mov word [r15 + 8 * 0 + 2], dx

mov eax, -128
imul dword [r15 + 8 * 1 + 0]
mov dword [r15 + 8 * 1 + 0], eax
mov dword [r15 + 8 * 1 + 4], edx

mov rax, -128
imul qword [r15 + 8 * 2 + 0]
mov rsi, rax
mov rsp, rdx

; Ensure correct zext mechanics

; 16bit - inserts
mov rax, 0xFFFFFFFFFFFF0001
mov rbx, 2
imul bl
mov rcx, rax

; 32bit - Zexts to 64bit
mov rax, 0xFFFFFFFF00000001
mov rbx, 2
imul ebx
mov rdx, rax

mov rax, [r15 + 8 * 0]
mov rbx, [r15 + 8 * 1]

hlt