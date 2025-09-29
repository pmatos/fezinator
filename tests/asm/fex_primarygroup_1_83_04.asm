; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_04.asm
; FEX_SHA256: f606788753a69d88ec94d0cab7404c73c8f875f270ad90a9da9895eb63106c1d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

and  word [rdx + 8 * 0 + 0], -31
and dword [rdx + 8 * 1 + 0], -31
and qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt