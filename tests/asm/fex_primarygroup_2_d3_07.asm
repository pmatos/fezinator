; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_07.asm
; FEX_SHA256: 41888ecca2c79d2cdfb76e1ac8edc918fe0a06effcc2c209db7fb2168c6b73a6
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

mov cl, 0x62
sar  word [rdx + 8 * 0 + 2], cl
sar dword [rdx + 8 * 1 + 0], cl
sar qword [rdx + 8 * 2 + 0], cl

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt