; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_00.asm
; FEX_SHA256: 1dfb881fd9363b2a1af5508c2cdee83dd7d3e602ecf3f0a0634ad6cf8f0ad892
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

add  word [rdx + 8 * 0 + 2], 0x6162
add dword [rdx + 8 * 1 + 0], 0x61626364
add qword [rdx + 8 * 2 + 0], 0x61626364

add qword [rdx + 8 * 3 + 0], -256

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt