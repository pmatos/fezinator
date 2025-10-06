; BITS: 64
; SOURCE: FEX TwoByte/0F_75.asm
; FEX_SHA256: c28d687b27469076abd3c20064b1f801dc969a644b99dc28be883161b646fae2
mov rdx, 0xe0000000

mov rax, 0x7172737475767778
mov [rdx + 8 * 0], rax
mov rax, 0x4142434445464748
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465667778
mov [rdx + 8 * 2], rax
mov rax, 0x5152535455564748
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
pcmpeqw mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
pcmpeqw mm1, mm2

hlt