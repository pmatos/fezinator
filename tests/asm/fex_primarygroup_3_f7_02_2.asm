; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_02_2.asm
; FEX_SHA256: 980223c1649baa1bb5818480285699614be43fa21658d7a3b196fc336a6017bd
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

lock not  word [rdx + 8 * 0 + 0]
lock not dword [rdx + 8 * 1 + 0]
lock not qword [rdx + 8 * 2 + 0]

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt