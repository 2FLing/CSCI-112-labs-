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
noAnsLbl	BYTE	"This equation has no answer.",0
resLbl	BYTE	"The roots are:",0
root1	BYTE	12 DUP (?),0dh,0ah
root2	BYTE	12 DUP (?)
ten		REAL4	10.0
one		REAL4	1.0
round	REAL4   0.000005
digit	DWORD	?

ftoa	MACRO	fnum,str
	push	eax
	lea		eax,str
	push	eax
	push	fnum
	call	ftoaProc
	add		esp,8
	pop		eax
	ENDM
.CODE       
_MainProc    PROC
	finit
	fld		bb		;put b in ST(0)
	fmul	bb		;b*b
	fild	four	;put 4 in ST(0)
	fmul	aa		;4*a
	fmul	cc		;4*a*c
	fsub			;b*b-4*a*c
	ftst			;b*b-4*a*c<0?
	fstsw	ax		;copy codition code to ax
	sahf			;shift condition code bits to flags
	jna		noAns	
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
	ftoa	x1,root1
	ftoa	x2,root2
	output	resLbl,root1
	jmp		endGE

	noAns:
	output  resLbl,noAnsLbl
	
	endGE:
	mov		eax,0
	ret
_MainProc    ENDP

;ftoa(fn,string)
;exp		[ebp-4]	DWORD	?
;byteTen	[ebp-8]	BYTE	10
ftoaProc	PROC
	push	ebp
	mov		ebp,esp
	sub		esp,8
	push	edi
	push	ecx
	push	eax
	mov		DWORD PTR [ebp-4],0
	mov		BYTE PTR [ebp-8],10
	finit
	fld		REAL4 PTR [ebp+8]
	mov		edi,[ebp+12]

	checkSign:
	ftst
	fstsw	ax
	sahf
	jnbe	Positive
	je		zero
	mov		BYTE PTR [edi],'-'
	inc		edi
	fchs
	Positive:
	mov		BYTE PTR [edi],' '
	inc		edi

	checkDigit:
	fcom	ten
	fstsw	ax
	sahf	
	jnae	elseLess

	untilLess:
	fdiv	ten
	inc		DWORD PTR [ebp-4]
	fcom	ten
	fstsw	ax
	sahf
	jnb		untilLess

	elseLess:
	fcom	one
	fstsw	ax
	sahf
	jnb		roundNum
	fmul	ten
	dec		DWORD PTR [ebp-4]
	jmp		elseLess

	roundNum:
	fadd	round
	fcom	ten
	fstsw	ax
	sahf
	jnae	saveFirstDigits
	fdiv	ten
	dec		DWORD PTR [ebp-4]


	saveFirstDigits:
	fld		st
	fisttp	digit
	fisub	digit
	fmul	ten
	mov		ebx,digit
	or		ebx,30h
	mov		BYTE PTR [edi],bl
	inc		edi
	mov		BYTE PTR [edi],'.'
	inc		edi
	mov		ecx,5

	saveRestDigits:
	fld		st
	fisttp	digit
	fisub	digit
	fmul	ten
	mov		ebx,digit
	or		ebx,30h
	mov		BYTE PTR [edi],bl
	inc		edi
	loop	saveRestDigits

	checkExp:
	mov		BYTE PTR [edi],'E'
	inc		edi
	mov		eax,DWORD PTR [ebp-4]
	cmp		eax,0
	jge		positiveExp
	mov		BYTE PTR [edi],'-'
	inc		edi
	neg		eax
	jmp		saveExp

	positiveExp:
	mov		BYTE PTR [edi],'+'
	inc		edi

	saveExp:
	div		BYTE PTR [ebp-8]
	or		al,30h
	or		ah,30h
	mov		BYTE PTR [edi],al
	inc		edi
	mov		BYTE PTR [edi],ah
	inc		edi
	jmp		finish

	zero:
	mov		BYTE PTR [edi],'0'
	inc		edi

	finish:
	pop		eax
	pop		ecx
	pop		edi
	mov		esp,ebp
	pop		ebp
	ret
ftoaProc	ENDP
END
