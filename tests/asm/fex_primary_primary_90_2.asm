; BITS: 64
; SOURCE: FEX Primary/Primary_90_2.asm
; FEX_SHA256: 9ced14467c6aa2efb61bc927f88d56aba952cb1d93516b4d4a26b9cfdc394d39
%macro swap32 2
mov %1, -1
mov eax, 0x42424242
xchg %1, eax

mov dword [r15 + 16 * %2 + 0], eax
mov dword [r15 + 16 * %2 + 8], %1

%endmacro

mov r15, 0xe0000000
mov rax, 0

mov [r15 + 8 * 0], rax
mov [r15 + 8 * 1], rax
mov [r15 + 8 * 2], rax
mov [r15 + 8 * 3], rax
mov [r15 + 8 * 4], rax
mov [r15 + 8 * 5], rax
mov [r15 + 8 * 6], rax
mov [r15 + 8 * 7], rax
mov [r15 + 8 * 8], rax
mov [r15 + 8 * 9], rax
mov [r15 + 8 * 10], rax
mov [r15 + 8 * 11], rax
mov [r15 + 8 * 12], rax
mov [r15 + 8 * 13], rax
mov [r15 + 8 * 14], rax
mov [r15 + 8 * 15], rax

swap32 r9d, 0
swap32 r10d, 1
swap32 r11d, 2
swap32 r12d, 3
swap32 r13d, 4
swap32 r14d, 5
swap32 r14d, 6
swap32 esp, 7

mov rax, [r15 + 16 * 0 + 0]
mov rbx, [r15 + 16 * 0 + 8]
mov rcx, [r15 + 16 * 1 + 0]
mov rdx, [r15 + 16 * 1 + 8]
mov rbp, [r15 + 16 * 2 + 0]
mov rsi, [r15 + 16 * 2 + 8]
mov rdi, [r15 + 16 * 3 + 0]
mov rsp, [r15 + 16 * 3 + 8]
mov r8,  [r15 + 16 * 4 + 0]
mov r9,  [r15 + 16 * 4 + 8]
mov r10, [r15 + 16 * 5 + 0]
mov r11, [r15 + 16 * 5 + 8]
mov r12, [r15 + 16 * 6 + 0]
mov r13, [r15 + 16 * 6 + 8]
mov r14, [r15 + 16 * 7 + 0]
mov r15, [r15 + 16 * 7 + 8]

hlt