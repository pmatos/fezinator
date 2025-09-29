; BITS: 64
; SOURCE: FEX Primary/Primary_98_2.asm
; FEX_SHA256: 03048e530b09d8db6321d677aaefb3cec46b5b7cf3b4c034f762a33dbe66d345
; Positive 8bit
mov rax, 0x4142434445464701
cbw
mov r15, rax

; Positive 16bit
mov rax, 0x4142434445460001
cwde
mov r14, rax

; Positive 32bit
mov rax, 0x4142434400000001
cdqe
mov r13, rax

; Negative 8bit
mov rax, 0x4142434445464781
cbw
mov r12, rax

; Negative 16bit
mov rax, 0x4142434445468001
cwde
mov r11, rax

; Negative 32bit
mov rax, 0x4142434480000001
cdqe
mov r10, rax

hlt