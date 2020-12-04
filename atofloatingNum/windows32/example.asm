; ASCII	to floating point code
; Author:  MingkuanPang
; Date:    12/3/2020    

.586
.MODEL FLAT
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
source	BYTE		"-78.375",0
result	REAL4	?

atof	MACRO  fNum
	push	eax
	lea		eax,fNum
	push	eax
	call	atofProc
	add		esp,4
	pop		eax
	ENDM
.CODE       
_MainProc    PROC
	atof	source
	fstp	result
	mov		eax,0
	ret
_MainProc    ENDP

;[ebp-4]	minus? 0 false -1 true
;[ebp-8]	point? 0 false -1 true
;[ebp-12]	ten 10
;[ebp-16]	digit
atofProc	PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	esi
	sub		esp,16
	mov		DWORD PTR [ebp-4],0
	mov		DWORD PTR [ebp-8],0
	mov		DWORD PTR [ebp-12],10
	mov		esi,[ebp+8]
	fld1
	fldz
		
	CheckSign:
	mov		al,BYTE PTR [esi]
	cmp		al,'-'
	jne		CheckDigit
	mov		DWORD PTR [ebp-4],-1
	inc		esi
	mov		al,BYTE PTR [esi]

	CheckDigit:
	cmp		al,'0'
	jl		endCheck
	cmp		al,'9'
	jg		endCheck
	and		eax,0000000fh
	mov		DWORD PTR [ebp-16],eax
	fimul	DWORD PTR [ebp-12]
	fiadd	DWORD PTR [ebp-16]
	cmp		DWORD PTR [ebp-8],-1
	jne		nextDigit
	fxch
	fimul	DWORD PTR [ebp-12]
	fxch

	nextDigit:
	inc		esi
	mov		al,BYTE PTR [esi]
	cmp		al,'.'
	jne		CheckDigit
	mov		DWORD PTR [ebp-8],-1
	inc		esi
	mov		al,BYTE PTR [esi]
	jmp		CheckDigit

	endCheck:
	fdivr
	cmp		DWORD PTR [ebp-4],-1
	jne		exit
	fchs

	exit:
	pop		esi
	pop		eax
	mov		esp,ebp
	pop		ebp
	ret
atofProc	ENDP
END
