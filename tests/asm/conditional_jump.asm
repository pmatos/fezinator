; BITS: 64
; LIVEIN: rdi
; LIVEOUT: rax, rflags
; EXITS: je skip_inc
; MEMORY: 
mov rax, 1
cmp rdi, 0    ; Compare input with 0
je skip_inc   ; JUMP skip_inc
inc rax       ; Increment if not zero
skip_inc: