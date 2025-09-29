; BITS: 64
; SOURCE: FEX Primary/Primary_87_3.asm
; FEX_SHA256: b187138566b9f0031fd304a1131b75d4a2289ad6aebb8d7c677b915349b10bea
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, -1
xchg qword [rdx + 8 * 0], rax
mov rbx, [rdx + 8 * 0]

hlt