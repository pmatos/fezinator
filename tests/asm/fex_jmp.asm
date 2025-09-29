; BITS: 64
; SOURCE: FEX JMP.asm
; FEX_SHA256: 70512b283ff3cb49ce58b102d05d66e7b645b297d555d9b451a3692b93a2f413
jmp label
label:

mov rsp, 0xe8000000

jmp function
func_return:

lea rbx, [rel function2]
jmp rbx
func2_return:

cmp rcx, rcx
je function3
func3_return:

mov rdx, 4
jne function4
func4_return:

hlt

function:
mov rax, 1
jmp func_return

function2:
mov rbx, 2
jmp func2_return

function3:
mov rcx, 3
jmp func3_return

function4:
mov rdx, 0xDEADBEEF
jmp func4_return

hlt