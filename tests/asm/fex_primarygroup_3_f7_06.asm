; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_06.asm
; FEX_SHA256: 7c9b3b1b8deaeb2c8adf38a9863c8b93cbbbaf401cbc9eb9fcfb9f427001bf09
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

mov ax, 0x7172
cwd
div word [r15 + 8 * 0 + 0]
mov word [r15 + 8 * 0 + 0], ax
mov word [r15 + 8 * 0 + 2], dx

mov eax, 0x71727374
cdq
div dword [r15 + 8 * 1 + 0]
mov dword [r15 + 8 * 1 + 0], eax
mov dword [r15 + 8 * 1 + 4], edx

mov rax, 0x7172737475767778
cqo
div qword [r15 + 8 * 2 + 0]
mov rsi, rax
mov rsp, rdx

; 128bit divide where we actually care about the upper bits containing real data
mov rax, 0x0
mov rdx, 0x1
mov rcx, 2
div rcx
mov r11, rax

mov rax, [r15 + 8 * 0]
mov rbx, [r15 + 8 * 1]

hlt