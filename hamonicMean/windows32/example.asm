;This program will caculate the harmonic mean of real numbers x and y
; Author:  MingkuanPang
; Date:    12/1/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
x		REAL4	1.0
y		REAL4	2.0
hMean	REAL4	?
two		REAL4	2.0
.CODE       
_MainProc    PROC
	fld		x
	fmul	y		;x*y
	fmul	two		;2*x*y
	fld		x
	fadd	y		;x+y
	fdiv			;2*x*y/(x+y)
	fstp	hMean	;store result in hMean
	mov		eax,0
	ret
_MainProc    ENDP
END
