; BITS: 64
; SOURCE: FEX STOSQ2_REPNE.asm
; FEX_SHA256: fdca3ef3a8bf5792412d5a8a1ba29b0e574c5b37e144e692d994f1bb54d7e759
; Starting address to store to
mov rdi, 0xe8000000
; Store value
mov rax, 0xDEADBEEFBAD0DAD1
mov [rdi], rax

; Set counter to zero
mov ecx, 0
; Set store value to zero
mov rax, 0

repne STOSQ

; Reload what we just stored
; Ensure that STOSQ didn't write
mov rdi, 0xe8000000
mov rax, [rdi]

hlt