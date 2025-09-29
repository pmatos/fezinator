; BITS: 64
; SOURCE: FEX Primary/Primary_87_2.asm
; FEX_SHA256: 06307d8bc8a75ca07ff8812139b6b90b71cd3e9f24332c34ad1a27372f553039
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, -1
xchg dword [rdx + 8 * 0], eax
mov rbx, [rdx + 8 * 0]

hlt