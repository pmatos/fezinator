; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_05.asm
; FEX_SHA256: 452188bdfc37293f65f1cf3e17ea5b4b7d872d4d9ab7f98e29588fe70f70a8b0
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

sub  word [rdx + 8 * 0 + 0], -31
sub dword [rdx + 8 * 1 + 0], -31
sub qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt