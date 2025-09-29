; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_07_2.asm
; FEX_SHA256: 11be10dedbb765800f94f02d77cebed359d0a28dcf8108bc7940141ecbb8ef33
mov rdx, 0xe0000000

mov rax, 0x4141414141418000
mov rbx, 0x80000000
mov rdx, 0x8000000000000000
mov rsi, 0x4242424242424280

mov cl, 7
sar sil, cl

mov cl, 15
sar ax, cl

mov cl, 31
sar ebx, cl

mov cl, 63
sar rdx, cl

hlt