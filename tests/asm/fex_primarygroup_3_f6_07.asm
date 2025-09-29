; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_07.asm
; FEX_SHA256: e44b627478a48f325f60f00d3300de288bb871eaed098dcafc62c3da2f229ddf
mov rdx, 0xe0000000

mov rax, 0x4142434445FE4748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x61626364656667F8
mov [rdx + 8 * 2], rax

; Positive / Negative
mov ax, 0x46
idiv byte [rdx + 8 * 0 + 2]
mov word [rdx + 8 * 0], ax

; Negative / Positive
mov ax, -128
idiv byte [rdx + 8 * 1]
mov word [rdx + 8 * 1], ax

; Negative / Negative
mov ax, -128
idiv byte [rdx + 8 * 2]
mov word [rdx + 8 * 2], ax

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt