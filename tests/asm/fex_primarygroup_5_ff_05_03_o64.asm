; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_05_03_o64.asm
; FEX_SHA256: 0ef1fd6264570f38406aafdc43837e20c2a9c1a1439b0f3168ab4a8712141c56
mov rsp, 0xe000_1000
mov ax, cs
lea edi, [rel .success]

sub rsp, 16
mov [rsp], edi
mov [rsp+4], cs

mov rax, 0
o64 call far [rsp]

hlt

.success:
mov rax, 1
mov rbx, rsp
o64 retf