; BITS: 64
; SOURCE: FEX Primary/Primary_A5_dword_REPNE.asm
; FEX_SHA256: 9e183fff9aa3602a429cff405041a270f3e1e77bb39abed39fbda84d37d6726b
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 2
repne movsd ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt