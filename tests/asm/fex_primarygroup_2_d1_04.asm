; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_04.asm
; FEX_SHA256: bab7b6446cccacf599dc0c5bd5c734efd7419cd5d67d05f4efa34f6b580e3a86
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

shl  word [rdx + 8 * 0 + 2], 1
shl dword [rdx + 8 * 1 + 0], 1
shl qword [rdx + 8 * 2 + 0], 1

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt