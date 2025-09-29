; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_01.asm
; FEX_SHA256: cd78c0265ad8eed5c23c5ad2e383872e31d1b47dd9821ae64447fc4276750e1d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

or  word [rdx + 8 * 0 + 0], -31
or dword [rdx + 8 * 1 + 0], -31
or qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt