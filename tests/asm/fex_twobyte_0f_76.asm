; BITS: 64
; SOURCE: FEX TwoByte/0F_76.asm
; FEX_SHA256: 6b287acc2b96bed1b3fbb8ede98cb49defc1bdff951415d210b0b7155bf71112
mov rdx, 0xe0000000

mov rax, 0x71727374FFFFFFFF
mov [rdx + 8 * 0], rax
mov rax, 0x41424344FFFFFFFF
mov [rdx + 8 * 1], rax

mov rax, 0x61626364FFFFFFFF
mov [rdx + 8 * 2], rax
mov rax, 0x51525354FFFFFFFF
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
pcmpeqd mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
pcmpeqd mm1, mm2

hlt