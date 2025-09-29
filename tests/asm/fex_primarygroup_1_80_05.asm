; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_05.asm
; FEX_SHA256: 1a3efc65b681e6020c394adab9a55092b514bfd97ff3fc1f283184711578572d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

sub byte [rdx + 8 * 0 + 1], 0x61
mov rax, [rdx + 8 * 0]

hlt