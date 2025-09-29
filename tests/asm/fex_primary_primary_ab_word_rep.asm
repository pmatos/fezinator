; BITS: 64
; SOURCE: FEX Primary/Primary_AB_word_REP.asm
; FEX_SHA256: 9fb1ce23d4b4d4b8e59e14febea2bcf521c9fb58461834cad464f71e42b888be
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]

cld
mov rcx, 0x4
mov rax, 0xF1F2
rep stosw ; rdi <- ax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt