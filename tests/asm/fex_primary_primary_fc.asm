; BITS: 64
; SOURCE: FEX Primary/Primary_FC.asm
; FEX_SHA256: e746e2b64cbe3f9486099fb82b9cfe08f1039a43ca9f0c55b35486f4fffeb0e2
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

lea rdi, [rdx + 8 * 0]

mov al, 0x0
cld
scasb

hlt