; BITS: 64
; SOURCE: FEX Primary/Primary_50.asm
; FEX_SHA256: 5d3cb2054071b74ebf5308f9b50647f3011791adf025c953c11aa37ddd3c5a69
mov rsp, 0xe0000080

mov rax, 1
mov rbx, 2
mov rcx, 3
mov rdx, 4
mov rbp, 5
mov rsi, 6
mov rdi, 7
mov r15, 8

push r15 ; Sub for rsp
push rdi
push rsi
push rbp
push rdx
push rcx
push rbx
push rax

mov rax, 0
mov rbx, 0
mov rcx, 0
mov rdx, 0
mov rbp, 0
mov rsi, 0
mov rdi, 0
mov r15, 0

pop rax
pop rbx
pop rcx
pop rdx
pop rbp
pop rsi
pop rdi
pop r15

hlt