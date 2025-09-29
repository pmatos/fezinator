; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_00.asm
; FEX_SHA256: 1b96387d5aa9e23215c4f10d550f0358bf47bc4e28955489ca77b55ebabaf059
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

rol  word [rdx + 8 * 0 + 2], 1
rol dword [rdx + 8 * 1 + 0], 1
rol qword [rdx + 8 * 2 + 0], 1

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt