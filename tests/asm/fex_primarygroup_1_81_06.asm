; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_06.asm
; FEX_SHA256: d230f5da69054bc543df52c1075b6a12c6bb40cb7c69e25f087d2b860eb2f7b3
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

xor  word [rdx + 8 * 0 + 2], 0x6162
xor dword [rdx + 8 * 1 + 0], 0x61626364
xor qword [rdx + 8 * 2 + 0], 0x61626364
xor qword [rdx + 8 * 3 + 0], -256

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt