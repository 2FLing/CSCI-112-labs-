; Author:  MingkuanPang
; Date:    10/29/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
number1	DWORD	1
number2	DWORD	2
number3	DWORD	3
letter	BYTE	'a'

ADD3	MACRO	num1,num2,num3
	mov		eax,num1
	add		eax,num2
	add		eax,num3
	ENDM
MAX2	MACRO	num1,num2
	LOCAL	endif
	mov		eax,num1
	cmp		eax,num2
	jge		endif
	mov		eax,num2
	endif:
	ENDM
MIN3	MACRO	num1,num2,num3
	LOCAL	nextif
	LOCAL	ending
	mov		eax,num1
	cmp		eax,num2
	jle		nextif
	mov		eax,num2
	nextif:
	cmp		eax,num3
	jle		ending
	mov		eax,num3
	ending:
	ENDM
Toupper		MACRO	letter
	LOCAL	ending
	cmp		letter,61h
	jl		ending
	push	eax
	lea		eax,letter
	sub		BYTE PTR [eax],20h
	pop		eax
	ending:
	ENDM
.CODE       
_MainProc    PROC
	;ADD3	number1,number2,number3
	;MAX2	number1,number2
	;MIN3	number1,number2,number3
	toUpper	letter
	mov		eax,0
	ret
_MainProc    ENDP
END