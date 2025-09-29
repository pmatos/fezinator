; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_04.asm
; FEX_SHA256: 274b84ed7110f7410abe73ea7a319a8401af382a9a12fcd183edf5b49f5b2343
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

mov cl, 0x62
shl  word [rdx + 8 * 0 + 2], cl
shl dword [rdx + 8 * 1 + 0], cl
shl qword [rdx + 8 * 2 + 0], cl

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt