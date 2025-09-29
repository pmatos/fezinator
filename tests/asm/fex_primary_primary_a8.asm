; BITS: 64
; SOURCE: FEX Primary/Primary_A8.asm
; FEX_SHA256: 8c28a05e0e573cbae0f3203d113796fd1530bd32d40e884e7e5f61b458844915
mov rax, 0x4142434445464847
test al, 0x61

mov rax, 0
lahf

hlt