; BITS: 64
; SOURCE: FEX Primary/Primary_E0.asm
; FEX_SHA256: 4c1e6a47263cdd2b30e8a3b965d54466861f4e9f6723f23b16ef222f32da5257
mov r15, 0xe0000000

mov rbx, 0xFFFFFFFFFFFFFF00
mov [r15 + 8 * 0], rbx
mov rbx, -1
mov [r15 + 8 * 1], rbx

mov rax, 0
mov rcx, 0x10
cmp byte [r15 + rcx - 1], 0xFF

jmp .head

.top:

add rax, 1
cmp byte [r15 + rcx - 1], 0xFF

.head:

loope .top

hlt