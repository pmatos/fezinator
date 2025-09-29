; BITS: 64
; SOURCE: FEX Primary/Primary_86.asm
; FEX_SHA256: 03c79e343e969fbd6d8b9d8971c1a533f238979c1c3b16b9621a362d0cd5730b
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, -1
xchg byte [rdx + 8 * 0], al
mov rbx, [rdx + 8 * 0]

hlt