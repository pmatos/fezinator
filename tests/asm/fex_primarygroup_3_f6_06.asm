; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_06.asm
; FEX_SHA256: 4677500d00678d4dcb07880d8296e398fd47795a9a3c3954b65bc18d1169367e
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov ax, 0x8E
div byte [rdx + 8 * 0 + 2]
mov word [rdx + 8 * 0], ax

mov rax, [rdx + 8 * 0]

hlt