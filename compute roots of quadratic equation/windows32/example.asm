;compute roots of quadratic equation
; Author:  MingkuanPang
; Date:    11/29/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
aa		REAL4	2.0
bb		REAL4	-1.0
cc		REAL4	-15.0
discr	REAL4	?
x1		REAL4	?
x2		REAL4	?
four	DWORD	4
two		DWORD	2
.CODE       
_MainProc    PROC
	finit
	fld		bb		;put b in ST(0)
	fmul			;b*b
	fild	four	;put 4 in ST(0)
	fmul	aa		;4*a
	fmul	cc		;4*a*c
	fsub			;b*b-4*a*c
	fldz			;set ST(0) 0
	fxch			;set b*b-4*a*c to ST(0)
	fcom	st(1)	;b*b-4*a*c<0?
	fstsw	ax		;copy codition code to ax
	sahf			;shift condition code bits to flags
	jnae	endGE
	fsqrt			;sqrt(b*b-4*a*c)
	fst		st(1)	;copy to ST(1)
	fsub	bb		;-b+sqrt(b*b-4*a*c)
	fdiv	aa		;-b+sqrt(b*b-4*a*c)/a
	fidiv	two		;-b+sqrt(b*b-4*a*c)/2a
	fstp	x1		;x1=-b+sqrt(b*b-4*a*c)/2a
	fchs			;-sqrt(b*b-4*a*c)		
	fsub	bb		;-b-sqrt(b*b-4*a*c)
	fdiv	aa		;-b-sqrt(b*b-4*a*c)/a
	fidiv	two		;-b-sqrt(b*b-4*a*c)/2a
	fstp	x2		;save and pop stack
	endGE:
	mov		eax,0
	ret
_MainProc    ENDP
END
