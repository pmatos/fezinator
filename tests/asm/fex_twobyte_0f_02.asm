; BITS: 64
; SOURCE: FEX TwoByte/0F_02.asm
; FEX_SHA256: 2df36a74aeb872eb973cfa97ef3ff3bf446f403d71701268cb36a2252ff1db1f
mov rdx, 0xe0000000

mov rax, 0x0
mov [rdx + 8 * 0], rax

mov rax, 201 ; Time
syscall
cmp rax, 0
setne [rdx + 8 * 0]
mov rax, [rdx + 8 * 0]

hlt