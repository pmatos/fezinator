; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_05.asm
; FEX_SHA256: 11b8bb0c003acd4ed5e6f08cd1bb1daefde3040b3f7c46bff9a4c87dee866c17
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov al, -2
imul byte [rdx + 8 * 0 + 1]
mov word [rdx + 8 * 0], ax

; Ensure upper bits aren't cleared
mov rax, 0xFFFFFFFFFFFFFF01
mov rbx, 1
imul bl
mov rbx, rax

mov rax, [rdx + 8 * 0]

hlt