; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_04.asm
; FEX_SHA256: 477526961815c109621def5808b57068dace0543273ab45bc1ca1f2142714502
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

and  word [rdx + 8 * 0 + 2], 0x6162
and dword [rdx + 8 * 1 + 0], 0x61626364
and qword [rdx + 8 * 2 + 0], 0x61626364
and qword [rdx + 8 * 3 + 0], -256

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]


hlt