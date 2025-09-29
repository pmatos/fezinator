; BITS: 64
; SOURCE: FEX Primary/Primary_87.asm
; FEX_SHA256: 40d8954110aeb2a8d1a012fecc2c1b55bedecfa2f505cf3da9f95fa9987e5394
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, -1
xchg word [rdx + 8 * 0], ax
mov rbx, [rdx + 8 * 0]

hlt