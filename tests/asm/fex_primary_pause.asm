; BITS: 64
; SOURCE: FEX Primary/Pause.asm
; FEX_SHA256: fcc4d077959e097c3de6f5d0c4ec8fb3cfd571489698f52f5962cceeab1d2e92
; Set rcx to an absurd number just incase something terrible occurs since pause = `rep nop`
mov rcx, -1

; Just ensure execution.
pause

hlt