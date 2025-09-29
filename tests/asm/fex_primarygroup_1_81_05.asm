; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_05.asm
; FEX_SHA256: 44aec1ba2933205d01f0806aecdb76435de484a75d0ff5a20f4051919ed55561
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

sub  word [rdx + 8 * 0 + 2], 0x6162
sub dword [rdx + 8 * 1 + 0], 0x61626364
sub qword [rdx + 8 * 2 + 0], 0x61626364
sub qword [rdx + 8 * 3 + 0], -256

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt