; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_07.asm
; FEX_SHA256: 601e8a868c45d2e3631b8a81378a2b575cb58ac6627f3f36afceaf14de83c44e
mov r15, 0xe0000000

; Positive
mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax
mov rax, 0
mov [r15 + 8 * 3], rax

; Positive
mov rax, 0x4142434445464748
mov [r15 + 8 * 4], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 5], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 6], rax
mov rax, 0
mov [r15 + 8 * 7], rax

; Negative
mov rax, -32
mov [r15 + 8 * 8], rax
mov rax, -64
mov [r15 + 8 * 9], rax
mov rax, -128
mov [r15 + 8 * 10], rax
mov rax, 0
mov [r15 + 8 * 11], rax

; Positive / Positive
mov ax, 0x7172
cwd
idiv word [r15 + 8 * 0 + 0]
mov word [r15 + 8 * 0 + 0], ax
mov word [r15 + 8 * 0 + 2], dx

mov eax, 0x71727374
cdq
idiv dword [r15 + 8 * 1 + 0]
mov dword [r15 + 8 * 1 + 0], eax
mov dword [r15 + 8 * 1 + 4], edx

mov rax, 0x7172737475767778
cqo
idiv qword [r15 + 8 * 2 + 0]
mov qword [r15 + 8 * 2 + 0], rax
mov qword [r15 + 8 * 3 + 0], rdx

; Negative / Positive
mov ax, -128
cwd
idiv word [r15 + 8 * 4 + 0]
mov word [r15 + 8 * 4 + 0], ax
mov word [r15 + 8 * 4 + 2], dx

mov eax, -128
cdq
idiv dword [r15 + 8 * 5 + 0]
mov dword [r15 + 8 * 5 + 0], eax
mov dword [r15 + 8 * 5 + 4], edx

mov rax, -128
cqo
idiv qword [r15 + 8 * 6 + 0]
mov qword [r15 + 8 * 6 + 0], rax
mov qword [r15 + 8 * 7 + 0], rdx

; Negative / Negative
mov ax, -128
cwd
idiv word [r15 + 8 * 8 + 0]
mov word [r15 + 8 * 8 + 0], ax
mov word [r15 + 8 * 8 + 2], dx

mov eax, -128
cdq
idiv dword [r15 + 8 * 9 + 0]
mov dword [r15 + 8 * 9 + 0], eax
mov dword [r15 + 8 * 9 + 4], edx

mov rax, -128
cqo
idiv qword [r15 + 8 * 10 + 0]
mov qword [r15 + 8 * 10 + 0], rax
mov qword [r15 + 8 * 11 + 0], rdx

; 128bit divide where we actually care about the upper bits containing real data
mov rax, 0x0
mov rdx, 0x1
mov rcx, 4
idiv rcx
mov qword [r15 + 8 * 12 + 0], rax
mov qword [r15 + 8 * 13 + 0], rdx

; Positive / Positive results
mov rax, [r15 + 8 * 0]
mov rbx, [r15 + 8 * 1]
mov rcx, [r15 + 8 * 2]
mov rdx, [r15 + 8 * 3]

; Negative / Positive results
mov rsi, [r15 + 8 * 4]
mov rdi, [r15 + 8 * 5]
mov rbp, [r15 + 8 * 6]
mov rsp, [r15 + 8 * 7]

; Negative / Negative results
mov r8, [r15 + 8 * 8]
mov r9, [r15 + 8 * 9]
mov r10, [r15 + 8 * 10]
mov r11, [r15 + 8 * 11]

; 128bit results
mov r12, [r15 + 8 * 12]
mov r13, [r15 + 8 * 13]

hlt