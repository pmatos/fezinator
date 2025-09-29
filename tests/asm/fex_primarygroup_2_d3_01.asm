; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_01.asm
; FEX_SHA256: 58a1cba862f518b3f9c5783d0758ca691d11bfafc0db2ced5c2617fd65545b40
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

mov cl, 0x62
ror  word [rdx + 8 * 0 + 2], cl
ror dword [rdx + 8 * 1 + 0], cl
ror qword [rdx + 8 * 2 + 0], cl

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt