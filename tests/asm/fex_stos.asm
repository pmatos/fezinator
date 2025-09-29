; BITS: 64
; SOURCE: FEX STOS.asm
; FEX_SHA256: c79cda731d3cc288de75710438ee8f20bcd4fda85522764af08c57bc5a0dbbb2
; Data we want to store
mov rax, 0xDEADBEEFBAD0DAD1

; Starting address to store to
mov rdi, 0xe8000000

; How many elements we want to store
mov rcx, 0x0

; Direction to increment (Increment when cleared)
cld

; Store bytes
rep stosw

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