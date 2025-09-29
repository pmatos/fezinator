; BITS: 64
; SOURCE: FEX Primary/ROL_OF.asm
; FEX_SHA256: e564e5735a12352ed3220bf6a9025e0b21300bbb7f5f66039817961f54ca9697
%macro clearof 0
mov r12, 0
ror r12, 1
%endmacro

%macro ofmerge 0
mov r14, 0
mov r13, 1
cmovo r14, r13

or r15, r14
shl r15, 1
%endmacro

mov r15, 0
mov r14, 1

; 1 bit rotate
; rol OF = XOR of LSB and MSB after rotate
clearof
mov rax, 0
mov rcx, 1
rol rax, cl
ofmerge

clearof
mov rax, 0x8000000000000000
mov rcx, 1
rol rax, cl
ofmerge

clearof
mov rax, 0xC000000000000000
mov rcx, 1
rol rax, cl
ofmerge

clearof
mov rax, 0x4000000000000000
mov rcx, 1
rol rax, cl
ofmerge

clearof
mov rax, 0
rol rax, 1
ofmerge

clearof
mov rax, 0x8000000000000000
rol rax, 1
ofmerge

clearof
mov rax, 0xC000000000000000
rol rax, 1
ofmerge

clearof
mov rax, 0x4000000000000000
rol rax, 1
ofmerge

hlt