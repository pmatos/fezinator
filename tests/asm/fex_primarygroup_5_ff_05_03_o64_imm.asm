; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_05_03_o64_imm.asm
; FEX_SHA256: 3872516b7d0011d2151e9d34ee72c1c2d00e2399234acaa5e3cfd53200b59094
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
o64 retf 0x8100