; BITS: 64
; SOURCE: FEX PrimaryGroup/6_C6_00.asm
; FEX_SHA256: e9d798ba2febf13899dd3d115f74bb93ddd31e89c42cde928525842f464ea736
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax

mov byte [rdx + 8 * 0 + 0], 0x61

mov rax, [rdx + 8 * 0]

hlt