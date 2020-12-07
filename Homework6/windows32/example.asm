; ASCII	to floating point code(Homework6)
; Author:  MingkuanPang
; Date:    12/3/2020    

.586
.MODEL FLAT
INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
string		BYTE 80 DUP (?)
inPrompt	BYTE "Please enter a string:",0
resLbl		BYTE "The reuslt will be:",0
strLen	MACRO	str
	lea		eax,str
	push	eax
	call	strLenProc
	add		esp,4
	ENDM

trimStr	MACRO	str
	push	eax
	lea		eax,str
	push	eax
	call	trimStrProc
	add		esp,4
	pop		eax
	ENDM

atof	MACRO	str
	push	eax
	lea		eax,str
	push	eax
	call	atofProc
	add		esp,4
	pop		eax
	ENDM

.CODE       
_MainProc    PROC
	input	inPrompt,string,80
	atof	string
	output	resLbl,string
	mov		eax,0
	ret
_MainProc    ENDP

;this program return the length of a string, stored in eax.
strLenProc		PROC
	push	ebp
	mov		ebp,esp
	push	esi
	mov		esi,[ebp+8]
	mov		eax,0

	checkChar:
	cmp		BYTE PTR [esi],0	;see if it is the end of the string
	je		finishChecking
	inc		eax					;if not eax+=1

	nextChar:
	inc		esi
	jmp		checkChar

	finishChecking:
	pop		esi
	pop		ebp
	ret
strLenProc		ENDP

;this program will take extra space off,and save it into a new string
;trimStr(string)
trimStrProc		PROC
	push	ebp
	mov		ebp,esp
	push	ecx
	push	esi
	push	edi
	mov		esi,[ebp+8]
	mov		edi,[ebp+8]

	SkipSpace:
	cmp	BYTE PTR [esi],0	;check if it is the end of the string
	je	finish
	cmp	BYTE PTR [esi],' '  ;if it is not space then save this character
	jne	saveChar			;otherwise skip it

	nextChar:
	inc		esi
	jmp		SkipSpace

	saveChar:
	movsb
	jmp		SkipSpace

	finish:
	mov	BYTE PTR [edi],0
	pop		edi
	pop		esi
	pop		ecx
	pop		ebp
	ret

trimStrProc		ENDP

;this program will transfer ascii to floating num
;and store in ST(0)
;atof(char [])
;[ebp-4] ten
;[ebp-8] point 0 false, -1 true
;[ebp-12] sign 0 false, -1 true
;[ebp-16] digit, initialized to 0
atofProc	PROC
	push	ebp
	mov		ebp,esp
	sub		esp,16
	mov		DWORD PTR [ebp-4],10	;int ten
	mov		DWORD PTR [ebp-8],0		;bool point=false
	mov		DWORD PTR [ebp-12],0	;bool neg=false
	push	eax
	push	ebx
	push	ecx
	push	esi
	mov		esi,[ebp+8]
	push	esi
	call	trimStrProc
	call	strLenProc	;set eax to be the length of the string
	add		esp,4
	mov		ecx,0

	initializeST:
	fld1		;set ST(0)=0.0, ST(1)=1.0
	fldz

	CheckSign:
	cmp		BYTE PTR [esi],'-'    ;check if the sign is minus
	jne		anymoreDigit
	mov		DWORD PTR [ebp-12],-1 ;if the sign is minus then neg=true
	inc		ecx
	inc		esi

	anymoreDigit:
	cmp		ecx,eax		;if ecx==eax then we are right at the end of the string
	je		ifNeg
	mov		bl,BYTE PTR [esi]
	cmp		bl,'.'
	je		point			; if this character is point, then point=true
	and		ebx,0000000fh	; otherwise convert it into decimal value
	mov		DWORD PTR [ebp-16],ebx	; value=ST(0)*10+value
	fimul	DWORD PTR [ebp-4]
	fiadd	DWORD PTR [ebp-16]

	checkPoint:							;if we already went through point
	cmp		DWORD PTR [ebp-8],-1		;ST(1) should multiply by 10 everytime when
	jne		nextDigit					;it is going through a digit
	fxch	
	fimul	DWORD PTR [ebp-4]
	fxch
	jmp		nextDigit

	point:
	mov		DWORD PTR [ebp-8],-1	;set point=true

	nextDigit:
	inc		ecx
	inc		esi
	jmp		anymoreDigit
	
	ifNeg:
	cmp		DWORD PTR [ebp-12],-1	;if sign==true, then make it to be negative
	jne		noMoreDigit
	fchs
	noMoreDigit:
	fdivr				;finally ST(0)/=ST(1)
	pop		esi
	pop		ecx
	pop		ebx
	pop		eax
	mov		esp,ebp
	pop		ebp
	ret
atofProc	ENDP
END
