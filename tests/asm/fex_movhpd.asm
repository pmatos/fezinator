; BITS: 64
; SOURCE: FEX MOVHPD.asm
; FEX_SHA256: 422dbe4e5782df76e944db33f14fd36cf7cb13e0bf18b520ead24691bad40b1b
; Data we want to store
mov rax, 0xDEADBEEFBAD0DAD1

; Starting address to store to
mov rdi, 0xe8000000

pxor xmm0, xmm0
pxor xmm1, xmm1

mov [rdi], rax

movhpd xmm0, [rdi]
movhpd [rdi + 8], xmm0

xor rcx, rcx
mov rcx, [rdi + 8]

hlt