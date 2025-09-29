; BITS: 64
; SOURCE: FEX fld.asm
; FEX_SHA256: 6a02e2c86a06c84aba978ae24757da75e9f43dadd0f389de81be14be13cc578d
lea rbp, [rel data]

; 32bit FLDs
fld dword [rbp]
fld dword [rbp + 4]
fld dword [rel allf] ; Currently fails due to lack of infinity handling

; 64bit FLDs
fld qword [rel allf] ; Currently fails due to lack of infinity handling

hlt

align 8
data:
        dd 0x40490fdb
        dd 0xaaaaaaaa
allf:   dq 0xffffffffffffffff
        dw 0xffff