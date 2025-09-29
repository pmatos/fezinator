; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_05.asm
; FEX_SHA256: d7b5ce0de3e962d466198ddf56e5838eb756637ef15c060b72f335cdf19d816f
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

shr byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt