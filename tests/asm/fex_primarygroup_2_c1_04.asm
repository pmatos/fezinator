; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C1_04.asm
; FEX_SHA256: b45fbe5ddce7fc0035254e6122afc9ea9c86f6a147f99ff6551802b0714ad31f
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

shl  word [rdx + 8 * 0 + 2], 0x62
shl dword [rdx + 8 * 1 + 0], 0x62
shl qword [rdx + 8 * 2 + 0], 0x62

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt