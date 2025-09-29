; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_06_2.asm
; FEX_SHA256: 30f3658f4966c6ed112786ee03e47c116f9aaf6a10c2a265d948ed368d7f4ded
mov r15, 0xe0000000

mov eax, 0x2
mov [r15 + 8 * 0], eax

mov rax, 0xFFFFFFFF00000000
mov rdx, 0xFFFFFFFF00000001

div dword [r15 + 8 * 0]

hlt