; Name: MyFactorialProc
; Author:  MingkuanPang
; Date:    10/22/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
number	DWORD	?
prompt1 BYTE    "Please enter a number",0
string     BYTE    30 DUP (?)
answer  BYTE    "The result is:",0
result    BYTE    11 DUP (?),   0 

;Macro for fctn1(factorial with no recursive)
factorial1  MACRO	number
			push	number
			call	fctn1
			add		esp,4
			ENDM

;Macro for fctn2(factorial with recursive)
factorial2	MACRO	number
			push	number
			mov		eax,1
			call	fctn2
			add		esp,4
			ENDM
.CODE       
_MainProc    PROC
	input	prompt1,string, 30
	atod	string
	mov		number,eax

	factorial1	number	;call factorial with no recursive
	;factorial2 number	;call factorial with recursive

	dtoa	result,eax
	output	answer,result
	mov		eax,0
	ret
_MainProc    ENDP



;Name:MyFactorialProc
;Parameter:DWORD size number
;Returns:Factorial of the number(in EAX)
fctn1   PROC
	push	ebp
	mov		ebp,esp
	push	ecx
	mov		eax,1
	mov		ecx,[ebp+8]
forloop1:
	imul	ecx
	loop	forloop1
	pop		ecx
	pop		ebp
	ret
fctn1   ENDP

;Name:MyFactorialProc(with recursive)
;Parameter:DWORD size number
;Returns:Factorial of the number(in EAX)
fctn2   PROC
	push	ebp
	mov		ebp,esp
	push	ebx
	mov		ebx,[ebp+8]
	cmp		ebx,1
	je		quitrecursive	;end the recursive if the number is 1
	imul	ebx
	dec		ebx
	push	ebx
	call	fctn2
	add		esp,4
quitrecursive:
	pop		ebx
	pop		ebp
	ret
fctn2   ENDP
END                           
