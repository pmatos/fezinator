; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_03.asm
; FEX_SHA256: e959593e2909cc150a578fc1add4c39fbb4ff9197b3bfa2785548dc8416608aa
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

neg  word [rdx + 8 * 0 + 0]
neg dword [rdx + 8 * 1 + 0]
neg qword [rdx + 8 * 2 + 0]

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt