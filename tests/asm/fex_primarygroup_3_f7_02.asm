; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_02.asm
; FEX_SHA256: 9e027f18483ec8e643e439b646526681742410ee5ff07028b9a3f148381a2f23
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

not  word [rdx + 8 * 0 + 0]
not dword [rdx + 8 * 1 + 0]
not qword [rdx + 8 * 2 + 0]

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt