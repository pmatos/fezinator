; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C1_07.asm
; FEX_SHA256: e2cf8bd75a15e47efe5093d898f68c4a6e5125f305365b1a50eb438d5fadf844
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

sar  word [rdx + 8 * 0 + 2], 0x62
sar dword [rdx + 8 * 1 + 0], 0x62
sar qword [rdx + 8 * 2 + 0], 0x62

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt