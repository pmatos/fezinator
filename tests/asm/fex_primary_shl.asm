; BITS: 64
; SOURCE: FEX Primary/SHL.asm
; FEX_SHA256: 47b88729ec2a549a1cd06a6e0bb42e838c968b2e15eb04e54f60cc2fc5f1e190
mov r14, -1
mov r13, -1
mov r12, -1
mov r11, -1
mov r10, -1
mov r9, -1
mov r8, -1
mov rbp, -1
mov rsp, -1
mov rdi, -1
mov rsi, -1

shl r14b, 0
shl r13b, 1
shl r12b, 2
shl r11b, 3
shl r10b, 4
shl r9b, 5
shl r8b, 6
shl bpl, 7
shl spl, 8
shl dil, 9
shl sil, 10

hlt