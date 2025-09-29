; BITS: 64
; SOURCE: FEX Primary/Primary_AF_REP_qword.asm
; FEX_SHA256: cce6c7f028ebbb3775f9bd5dd3915889e007f9b9be8dd1a8c01e1a716224af0a
mov rdx, 0xe0000000

mov rax, 0x6162636465666768
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 0]

cld
mov rax, 0x6162636465666768
mov rbx, 0x6162636465666768
mov rcx, 8
cmp rax, rbx

rep scasq

hlt