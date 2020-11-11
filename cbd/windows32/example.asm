; Author:  MingkuanPang
; Date:    10/29/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data

string	BYTE	30	DUP(0),0
num		DWORD	0
inprompt	BYTE	"Please enter your binary number",0
result	BYTE	11 DUP(?),0
answer	BYTE	"Convert it to decimal it will be :",0
btod MACRO	str,num
	lea		eax,num
	push	eax
	lea		eax,str
	push	eax
	call	btodProc
	add		esp,8
	ENDM
.CODE       
_MainProc    PROC	
	input	inprompt,string,30
	btod	string,num
	dtoa	result,num
	output	answer,result
	ret
_MainProc    ENDP

;convert binary to decimal
btodProc	PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	eax
	push	ebx
	push	ecx
	mov		esi,[ebp+8];string
	mov		eax,[ebp+12];num
	mov		ecx,-1h		;initialize ecx to -1, because the first place in binary num represent 2^0
						; so when counting the digits of the num, it should start from -1.
	cmp		BYTE PTR [esi],0h ; if the num is '\0', that means it is a empty string, then quit the proc
	je		quitproc
	whileloop:			;count the digits of the binary num
	cmp		BYTE PTR [esi],0h
	je		endwhileloop
	inc		ecx
	inc		esi
	jmp		whileloop
	endwhileloop:
	sub		esi,ecx		;reset the pointer to the first digit of the binary num
	dec		esi
	mov		ebx,1
	shl		ebx,cl		;2^n(n==cl)
	cmp		BYTE PTR [esi],'0'
	je		bytezero
	mov		ecx,1
	jmp		setdigit
	bytezero:
	mov		ecx,0	;check the digit is '0' or '1', digit of decimal should be n(num on that digit)*2^m(digits on the binary num)
	setdigit:
	and		cx,000000ffh
	imul	ebx,ecx
	add		DWORD PTR [eax],ebx
	inc		esi
	mov		ebx,esi
	push	eax
	push	esi
	call	btodProc
	add		esp,8
	quitproc:
	pop		ecx
	pop		ebx
	pop		eax
	pop		esi
	pop		ebp
	ret
btodProc	ENDP
END