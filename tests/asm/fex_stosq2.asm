; BITS: 64
; SOURCE: FEX STOSQ2.asm
; FEX_SHA256: 50458245ed608685593c808c68f1a2f1338210af091c921a5ca8ea2bf788714a
; Starting address to store to
mov rdi, 0xe8000000
; Store value
mov rax, 0xDEADBEEFBAD0DAD1
mov [rdi], rax

; Set counter to zero
mov ecx, 0
; Set store value to zero
mov rax, 0

rep STOSQ

; Reload what we just stored
; Ensure that STOSQ didn't write
mov rdi, 0xe8000000
mov rax, [rdi]

hlt