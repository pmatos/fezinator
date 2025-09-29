; BITS: 64
; SOURCE: FEX movups.asm
; FEX_SHA256: 1540d6a24b00ea187a444b9f600dfe1c3cc3e3ade4cdb1a39539f7d84d2c843f
jmp label
label:
mov rax, 0x3f800000
;mov rsi, 0xdeadbeefbaddad1
;rdseed eax
;vpermd ymm0, ymm1, ymm2
mov rdx, 0xe0000000
mov [rdx], eax
mov eax, 0x40000000
mov [rdx + 8], eax

movups xmm0, [rdx]
movups xmm1, xmm0

movups [rdx + 16], xmm1
movups xmm2, [rdx + 16]

; Upper moves
mov eax, 0x80000000

mov [rdx + 32], eax
mov eax, 0x81000000
mov [rdx + 36], eax

movups xmm3, xmm0
movhps xmm3, [rdx + 32]

mov rax, 0xDEADBEEFBAD0DAD1
mov [rdx + 32], rax
mov rax, 0x4141414142424242
mov [rdx + 40], rax
movups xmm4, [rdx + 32]
movq xmm5, [rdx + 32]

por xmm4, xmm0
movq xmm6, xmm4
paddq xmm7, xmm6
mov rax, 0xFFFFFFFFFFFFFFFF
mov [rdx + 32], rax
mov [rdx + 40], rax
movdqu xmm8, [rdx + 32]
pmovmskb eax, xmm8

;fcomp dword [0]
;fldl2t
;fld1
hlt