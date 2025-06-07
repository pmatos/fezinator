; BITS: 64
; LIVEIN: rsi, rdi
; LIVEOUT: rax, rflags
; EXITS: 
; MEMORY: LOAD rsi, STORE rdi
mov rax, [rsi]  ; LOAD rsi
add rax, 10
mov [rdi], rax  ; STORE rdi