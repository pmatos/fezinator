; BITS: 64
; SOURCE: FEX TwoByte/0F_19.asm
; FEX_SHA256: c2e2c70efc10bd794b3cabc1839406170aaac2267a320b9e393051b3a1523369
%macro nop_enc 1
db 0x0F
db %1
db 0x02

db 0x66
db 0x0F
db %1
db 0x02

db 0x48
db 0x0F
db %1
db 0x02

%endmacro

mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

nop word [rdx + 8 * 0]
nop dword [rdx + 8 * 0]
nop qword [rdx + 8 * 0]

; These nops can't be encoded via regular means
nop_enc 0x19
nop_enc 0x1A
nop_enc 0x1B
nop_enc 0x1C
nop_enc 0x1D
nop_enc 0x1E

; Just ensure they didn't do anything to this memory location
movaps xmm0, [rdx + 8 * 0]

hlt