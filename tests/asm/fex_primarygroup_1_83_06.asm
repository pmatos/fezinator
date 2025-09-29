; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_06.asm
; FEX_SHA256: 2c94c2d656c9d07ada9e001fdc0083c7d44da59927deb69d68884f9141139d78
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

xor  word [rdx + 8 * 0 + 0], -31
xor dword [rdx + 8 * 1 + 0], -31
xor qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt