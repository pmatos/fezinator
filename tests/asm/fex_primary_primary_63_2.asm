; BITS: 64
; SOURCE: FEX Primary/Primary_63_2.asm
; FEX_SHA256: 7bd273a7f037793653fb268880654a2623e59c94a8de9a8a17d4057ec7b5349b
mov rax, 0x4142434445464748
mov rbx, 0x4142434445464748
mov rcx, 0x4142434445464748
mov rdx, 0x4142434445464748
mov rsp, 0x6666666681828384

; Default: 0x48, 0x63, 0xc4
movsxd rax, esp
; Default with o16 prefix: 0x66, 0x48, 0x63, 0xc4
o16 movsxd rbx, esp
; No-rex widening prefix
db 0x63, 0xcc ; movsxd ecx, esp
; o16 prefix with no-rex widening
db 0x66, 0x63, 0xd4 ; movsxd dx, sp

hlt