; BITS: 64
; SOURCE: FEX MemoryData.asm
; FEX_SHA256: 0b3d61b4af3d7f43fd993574547adbb3a4ae6f78b982252e1778949863c12d64
; Simple test to prove that config loader's MemoryData is working

mov rax, [0x10000000]
hlt