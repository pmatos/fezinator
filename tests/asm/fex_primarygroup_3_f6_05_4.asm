; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_05_4.asm
; FEX_SHA256: 2f0331e273c80f6c8bf0e1392eb6d9708fa103d2984f89faae86ceb288ca4edd
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
mov eax, 0x80000000
mov ebx, 0x80000000

imul ebx

ofcfmerge

; Max Positive
mov eax, 0x7FFFFFFF
mov ebx, 0x7FFFFFFF

imul ebx

ofcfmerge

; Max Positive and Max Negative
mov eax, 0x7FFFFFFF
mov ebx, 0x80000000

imul ebx

ofcfmerge

; Max Positive and Max Negative
mov eax, 0x80000000
mov ebx, 0x7FFFFFFF

imul ebx

ofcfmerge

; No Overflow

mov eax, 0x1
mov ebx, 0x1

imul ebx

ofcfmerge

hlt