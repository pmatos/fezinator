; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_05.asm
; FEX_SHA256: 22e82740f3085ddb10306286cae55ee6bcca0ea6f19afcfa6d012a3064f1038c
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

mov cl, 0x62
shr  word [rdx + 8 * 0 + 2], cl
shr dword [rdx + 8 * 1 + 0], cl
shr qword [rdx + 8 * 2 + 0], cl

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt