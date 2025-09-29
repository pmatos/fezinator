; BITS: 64
; SOURCE: FEX Primary/Primary_E1.asm
; FEX_SHA256: 2cd667a278b88c4c173714429e9c1070be4e37bb6900a037019af3d14afdbb0c
mov r15, 0xe0000000

mov rbx, 0xFFFFFFFFFFFFFF00
mov [r15 + 8 * 0], rbx
mov rbx, -1
mov [r15 + 8 * 1], rbx

mov rax, 0
mov rcx, 0x10
cmp byte [r15 + rcx - 1], 0

jmp .head

.top:

add rax, 1
cmp byte [r15 + rcx - 1], 0

.head:

loopne .top

hlt