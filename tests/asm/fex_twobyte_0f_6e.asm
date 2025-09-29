; BITS: 64
; SOURCE: FEX TwoByte/0F_6E.asm
; FEX_SHA256: d2fcfc9448a199e3965033831acd307afb07eeb381b29aac6d0db612ba9b232e
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

mov rax, 0x0
mov [rdx + 8 * 4], rax
mov [rdx + 8 * 5], rax

mov rax, qword [rdx + 8 * 0]
mov rbx, qword [rdx + 8 * 1]

movd mm0, eax
movq mm1, rbx

movd mm2, dword [rdx + 8 * 0]
movq mm3, qword [rdx + 8 * 1]

hlt