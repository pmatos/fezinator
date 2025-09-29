; BITS: 64
; SOURCE: FEX Primary/Primary_8D_2.asm
; FEX_SHA256: a4afa6b1e1acea880f0d69226cc8da79d6a7bd59780523ab99bf28fec6b50e81
mov rax, -1
mov rbx, -1

lea rax, [ebx]

mov rbx, -1
mov rcx, -1

lea ebx, [ecx]

mov rcx, 0x4142434445464748
mov rdx, -1

lea cx, [edx]

mov rdx, 0x4142434445464748
mov rdi, -1

lea dx, [rdi]

mov rdi, 0x4142434445464748
mov rsi, 0xFFFFFFFF00000000
mov rbp, 1

lea rdi, [esi + ebp]

mov rsi, 0x4142434445464748
mov rbp, 0xFFFFFFFF00000000
mov rsp, 1

lea esi, [rbp + rsp]

mov rbp, 0x4142434445464748
mov rsp, 0xFFFFFFFF00000000
mov r9,  0x0000000200000000

lea ebp, [esp + r9d]

mov rsp, 0x4142434445464748
mov r9,  0xFFFFFFFF00000000
mov r10, 0x0000000200000000

lea rsp, [r10d + r9d]

hlt