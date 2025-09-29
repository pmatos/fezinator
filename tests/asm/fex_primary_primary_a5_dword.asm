; BITS: 64
; SOURCE: FEX Primary/Primary_A5_dword.asm
; FEX_SHA256: adf7372c0d560ad725dc3261373cd387380d7fa788cbfd7a869db57dec2879ae
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
movsd ; rdi <- rsi
movsd

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt