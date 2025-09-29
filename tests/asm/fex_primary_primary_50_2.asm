; BITS: 64
; SOURCE: FEX Primary/Primary_50_2.asm
; FEX_SHA256: 56963f0ee7a7ec646a7c8a95195baba2011b1b2022f29556bba2c6ae847c3d4d
mov rsp, 0xe0000080

mov rax, 1
mov rbx, 2
mov rcx, 3
mov rdx, 4
mov rbp, 5
mov rsi, 6
mov rdi, 7
mov r15, 8

push r15w ; Sub for rsp
push di
push si
push bp
push dx
push cx
push bx
push ax

mov rax, 0
mov rbx, 0
mov rcx, 0
mov rdx, 0
mov rbp, 0
mov rsi, 0
mov rdi, 0
mov r15, 0

pop ax
pop bx
pop cx
pop dx
pop bp
pop si
pop di
pop r15w

hlt