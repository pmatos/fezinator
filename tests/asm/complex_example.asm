; BITS: 64
; LIVEIN: rdi, rsi, rdx
; LIVEOUT: rax, rflags
; EXITS: jz zero_case, jmp end
; MEMORY: LOAD rsi, STORE rdx
mov rax, [rsi]    ; LOAD rsi - Load value from source
test rdi, rdi     ; Test if rdi is zero
jz zero_case      ; JUMP zero_case
add rax, rdi      ; Add the input value
jmp end           ; JUMP end
zero_case:
    mov rax, 0    ; Set result to 0
end:
    mov [rdx], rax ; STORE rdx - Store result