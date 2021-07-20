; --
; -- Misc
; --

macro dwbe
rept _NARG
    dw (\1>>8)+((\1&$ff)<<8)
    shift
endr
endm

macro dbw
    db \1
    dw \2
endm

macro dbwbe
    db \1
    dwbe \2
endm

; macro ldbc
;     ld bc, (\1<<8)|\2
; endm

; macro ldde
;     ld de, (\1<<8)|\2
; endm

; macro ldhl
;     ld hl, (\1<<8)|\2
; endm

macro lda
ASSERT \1 == 0
	xor a
endm
