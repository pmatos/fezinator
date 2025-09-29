; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_07.asm
; FEX_SHA256: 5a02e43a5ecb7d4eb1b1824f163ca6d42ee86a9fe27eaf8951613156090412ef
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

sar  word [rdx + 8 * 0 + 2], 1
sar dword [rdx + 8 * 1 + 0], 1
sar qword [rdx + 8 * 2 + 0], 1

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt