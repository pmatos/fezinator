; BITS: 64
; SOURCE: FEX Primary/Primary_63.asm
; FEX_SHA256: d0cfbe1a4850640a413bb0b86c5465c3164b7c732a2fcb116889a0f1e5c89a4c
mov rax, 0x81828384
mov rbx, 0x71727374
movsxd rax, eax
movsxd rbx, ebx

hlt