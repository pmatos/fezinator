; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_01.asm
; FEX_SHA256: 1dd70de7a17dd1794976318d687d17a385c3709b53ead4b37a9a1e926077ad7f
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

or  word [rdx + 8 * 0 + 2], 0x6162
or dword [rdx + 8 * 1 + 0], 0x61626364
or qword [rdx + 8 * 2 + 0], 0x61626364

or qword [rdx + 8 * 3 + 0], -256

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]


hlt