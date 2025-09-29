; BITS: 64
; SOURCE: FEX Primary/Primary_A6_REP_Equal.asm
; FEX_SHA256: fe59066fc9fb6df2bcf41469a42432ab3835cdc5708fb2274699adedd7b83288
%macro copy 3
  ; Dest, Src, Size
  mov rdi, %1
  mov rsi, %2
  mov rcx, %3

  cld
  rep movsb
%endmacro

mov rdx, 0xe0000000

lea r15, [rdx + 8 * 0]
lea r14, [rel .StringOne]
copy r15, r14, 11

lea r15, [rdx + 8 * 2]
lea r14, [rel .StringTwo]
copy r15, r14, 11

lea rdi, [rdx + 8 * 0]
lea rsi, [rdx + 8 * 2]

cld
mov rcx, 10 ; Lower String length
repe cmpsb ; rdi cmp rsi
mov rax, 0
lahf

mov rdx, 0
sete dl

hlt

.StringOne: db "TestString\0"
.StringTwo: db "TestString\0"