; BITS: 64
; SOURCE: FEX PrimaryGroup/6_C7_00.asm
; FEX_SHA256: 01baaca7927eac376dfbabcf530fe6d7b442eebad5d5f3318f55be05b40b2274
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

mov  word [rdx + 8 * 0 + 0], 0x6162
mov dword [rdx + 8 * 1 + 0], 0x61626364
mov qword [rdx + 8 * 2 + 0], 0x61626364
mov qword [rdx + 8 * 3 + 0], -128

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt