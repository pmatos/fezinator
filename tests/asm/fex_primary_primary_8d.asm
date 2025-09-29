; BITS: 64
; SOURCE: FEX Primary/Primary_8D.asm
; FEX_SHA256: 6874c5ef4303529e46dfe795d4a3076af5ad5d2ea0267b719f6d9b45882f8f8a
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov rdx, 0x5152535455565758

; SIB gives us `scale * index + base + offset`
; scale = constant {1, 2, 4, 8}
; Index = <Reg>
; Base = <Reg>
; Offset = Constant {imm8, imm32}
lea r15, [rax]
lea r14, [rax + rdx]

lea r13d, [eax]
lea r12d, [eax + edx]

lea r11, [2 * rax]
lea r10, [4 * rax + rdx]

lea r9, [rax + 0x61]
lea r8, [rax + rdx + 0x61626364]

mov rsi, -1
lea si, [rax + rdx + 0x61626364]

hlt