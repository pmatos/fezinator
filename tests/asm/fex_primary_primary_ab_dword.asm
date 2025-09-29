; BITS: 64
; SOURCE: FEX Primary/Primary_AB_dword.asm
; FEX_SHA256: 855c3fcd7e6c9b123023888e82328ddd7666f2a2ef2c1f599f7948d304abfd41
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]

cld
mov rax, 0xF1F2F3F4
stosd ; rdi <- eax
stosd

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt