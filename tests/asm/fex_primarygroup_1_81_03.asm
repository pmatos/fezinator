; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_03.asm
; FEX_SHA256: 590afe6652fbd558b91b5a1b319941ccd595af7ae1881d964956f99ce0750399
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

clc
sbb  word [rdx + 8 * 0 + 2], 0x6162
clc
sbb dword [rdx + 8 * 1 + 0], 0x61626364
clc
sbb qword [rdx + 8 * 2 + 0], 0x61626364
clc
sbb qword [rdx + 8 * 3 + 0], -256

stc
sbb  word [rdx + 8 * 0 + 4], 0x6162
stc
sbb dword [rdx + 8 * 1 + 0], 0x61626364
stc
sbb qword [rdx + 8 * 2 + 0], 0x61626364
stc
sbb qword [rdx + 8 * 3 + 0], -256

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt