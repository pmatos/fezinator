; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_07.asm
; FEX_SHA256: 063c8ba0470341f8fc3b5beae743cb0259a10741b4254ea3c34ef0bec7a6fe52
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

sar byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt