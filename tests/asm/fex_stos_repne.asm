; BITS: 64
; SOURCE: FEX STOS_REPNE.asm
; FEX_SHA256: ef6d3f58333a2bddd0ccf639c5022001798f0f9da79c4476ccc24fee8c0c61db
; Data we want to store
mov rax, 0xDEADBEEFBAD0DAD1

; Starting address to store to
mov rdi, 0xe8000000

; How many elements we want to store
mov rcx, 0x0

; Direction to increment (Increment when cleared)
cld

; Store bytes
repne stosw

mov r11, 0
mov r10, 0xe8000000

movzx r12, word [r10 + 0]
add r11, r12
movzx r12, word [r10 + 1]
add r11, r12
movzx r12, word [r10 + 2]
add r11, r12
movzx r12, word [r10 + 3]
add r11, r12
movzx r12, word [r10 + 4]
add r11, r12
movzx r12, word [r10 + 5]
add r11, r12
movzx r12, word [r10 + 6]
add r11, r12
movzx r12, word [r10 + 7]
add r11, r12
movzx r12, word [r10 + 8]
add r11, r12
movzx r12, word [r10 + 9]
add r11, r12
movzx r12, word [r10 + 10]
add r11, r12
movzx r12, word [r10 + 11]
add r11, r12
movzx r12, word [r10 + 12]
add r11, r12
movzx r12, word [r10 + 13]
add r11, r12
movzx r12, word [r10 + 14]
add r11, r12
movzx r12, word [r10 + 15]
add r11, r12

hlt