; BITS: 64
; SOURCE: FEX Primary/Primary_A6_REP_down.asm
; FEX_SHA256: c50694a761d3e0d5e8228dbbc599dcf6a43d69948d90599c8468c7c7c4eca066
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
copy r15, r14, 14

lea r15, [rdx + 8 * 2]
lea r14, [rel .StringTwo]
copy r15, r14, 14

lea rdi, [rdx + 8 * 0 + 13]
lea rsi, [rdx + 8 * 2 + 13]

std
mov rcx, 10 ; Lower String length
repe cmpsb ; rdi cmp rsi
mov rax, 0
lahf

mov rdx, 0
sete dl

hlt

.StringOne: db "\0\0\0\0TestString"
.StringTwo: db "\0TestUnmatched"