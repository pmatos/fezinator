; BITS: 64
; SOURCE: FEX CALL.asm
; FEX_SHA256: 32e93fbc39c9915d92eea2b63716980a68ea3572ca7dba8da49a2358bfe50a00
jmp label
label:

mov rsp, 0xe8000000

; Test direct literal call
call function

; Move the absolute address of function2 in to rbx and call it
lea rbx, [rel function2]
call rbx

hlt

function:
mov rax, 1
ret

function2:
mov rbx, 2
ret

hlt