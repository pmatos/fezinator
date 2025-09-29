; BITS: 64
; SOURCE: FEX Primary/Primary_84.asm
; FEX_SHA256: a7869b326015fb6f0fbc32242529b9d77b75a672413d745af5eabf7e9030a820
mov rax, 0x4142434445464847
mov rbx, 0x61
test al, bl

mov rax, 0
lahf

hlt