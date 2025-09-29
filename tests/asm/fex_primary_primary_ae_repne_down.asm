; BITS: 64
; SOURCE: FEX Primary/Primary_AE_REPNE_down.asm
; FEX_SHA256: 201391a217a9df514615eb8773a237b8304cf3566e9786f48a899204ca65c483
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5161535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 2]

std
mov rax, 0x61
mov rcx, 8
cmp rax, 0

repne scasb

hlt