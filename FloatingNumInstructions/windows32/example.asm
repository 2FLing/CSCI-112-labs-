;compute roots of quadratic equation
; Author:  MingkuanPang
; Date:    11/29/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
 fpTemp1	REAL4	9.0
 fpTemp2	REAL4	12.0
 fpTemp3	REAL4	23.0
 fpTemp4	REAL4	24.0
 fpTemp5	REAL4	35.0
 fpValue	REAL4	0.5
 intValue	DWORD	6
.CODE       
_MainProc    PROC
InitializedST:
	finit
	fld		fpTemp5
	fld		fpTemp4
	fld		fpTemp3
	fld		fpTemp2
	fld		fpTemp1

Instructions:
	;fld	st(2)
	;fld	fpValue
	;fild	intValue
	;fldpi
	;fst	st(4)
	;fstp	st(4)
	;fst	fpValue
	;fistp	intValue
	;fxch	st(3)
	;fadd
	;fadd	st(3),st
	;fadd	st,st(3)
	;faddp	st(3),st
	;fsub	fpValue
	;fisub	intValue
	;fisubr	intValue
	;fsubp	st(3),st
	;fmul	st,st(4)
	;fmul	;pop ST and ST(1) mutiple and push the product into the stack
	;fmul	fpValue
	;fdiv
	;fdivr
	;fidiv	intValue
	;fdivp	st(2),st	;replace ST(2) by the quotient and pop ST from stack
	;fchs
	fsqrt
	mov		eax,0
	ret
_MainProc    ENDP
END
