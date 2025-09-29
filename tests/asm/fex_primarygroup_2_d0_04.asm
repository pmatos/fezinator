; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_04.asm
; FEX_SHA256: dc515b8470aa4a58913b3aa34fc1d6b9cc4365cde60289deadbaee4624286c7a
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

shl byte [rdx + 8 * 0 + 1], 1

mov rax, [rdx + 8 * 0]

hlt