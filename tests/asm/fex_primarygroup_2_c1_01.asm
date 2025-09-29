; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C1_01.asm
; FEX_SHA256: 0cd9b62cc34abbefe8598a973de7575308c8e729d3d0c98d2602c5930028352d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

ror  word [rdx + 8 * 0 + 2], 0x62
ror dword [rdx + 8 * 1 + 0], 0x62
ror qword [rdx + 8 * 2 + 0], 0x62

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt