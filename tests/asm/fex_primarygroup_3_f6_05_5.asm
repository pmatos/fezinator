; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_05_5.asm
; FEX_SHA256: 8c27c10b5d83ea124cbe35d3a1a521a79e98b03f359993c800757af9834646e7
%macro ofcfmerge 0
  ; Get CF
  setc al
  ; Get OF
  seto bl
  and eax, 1
  and ebx, 1

  ; Merge in to results
  shl edi, 1
  or edi, eax

  ; Merge in to results
  shl edi, 1
  or edi, ebx
%endmacro

mov edi, 0

; Max Negative
mov rax, 0x8000000000000000
mov rbx, 0x8000000000000000

imul rbx

ofcfmerge

; Max Positive
mov rax, 0x7FFFFFFFFFFFFFFF
mov rbx, 0x7FFFFFFFFFFFFFFF

imul rbx

ofcfmerge

; Max Positive and Max Negative
mov rax, 0x7FFFFFFFFFFFFFFF
mov rbx, 0x8000000000000000

imul rbx

ofcfmerge

; Max Positive and Max Negative
mov rax, 0x8000000000000000
mov rbx, 0x7FFFFFFFFFFFFFFF

imul rbx

ofcfmerge

; No Overflow

mov rax, 0x1
mov rbx, 0x1

imul rbx

ofcfmerge

hlt