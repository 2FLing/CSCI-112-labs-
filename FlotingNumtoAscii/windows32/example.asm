; ASCII	to floating point code(Homework)
; Author:  MingkuanPang
; Date:    12/3/2020    

.586
.MODEL FLAT
INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
ten		REAL4	10.0
one		REAL4	1.0
round	REAL4   0.000005
digit	DWORD	?
string BYTE	80 DUP (?)
fnumber	REAL4	0.00021
resLbl	BYTE	"The result will be: ",0

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
	ftoa	fnumber,string
	output	resLbl,string
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
