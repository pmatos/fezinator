; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_01.asm
; FEX_SHA256: 72d6d45053099377184726d3e3fe19966e820f3b0751cda2e85541e26a1ac554
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

ror  word [rdx + 8 * 0 + 2], 1
ror dword [rdx + 8 * 1 + 0], 1
ror qword [rdx + 8 * 2 + 0], 1

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt