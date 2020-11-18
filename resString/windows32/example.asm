; Example assembly language program
; This program print the rest of the strings
;after the character that has been inputed.
; all the strings that had been inputed
; Author:  MingkuanPang
; Date:    11/15/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
string			BYTE	90 DUP(?)
char			BYTE	5  DUP(?)
inprompt		BYTE	"Please enter a string",0
charprompt		BYTE	"Please enter a character",0
resultLbl		BYTE	"The rest of string is: ",0

reString  MACRO	str,char
		mov		eax,0
		mov		al,char
		push	eax
		lea		eax,str
		push	eax
		call	reStringProc
		add		esp,8
		ENDM

.CODE       
_MainProc    PROC
	input		inprompt,string,90
	input		charprompt,char,5
	reString	string,char
	output		resultLbl,[eax]
	mov			eax,0
	ret
_MainProc    ENDP

reStringProc	PROC
	push	ebp
	mov		ebp,esp
	push	edi
	push	ecx
	mov		edi,[ebp+8]
	push	edi
	call	strLenProc
	add		esp,4
	inc		eax
	mov		ecx,eax
	mov		eax,[ebp+12]
	cld
	repne	scasb
	dec		edi
	mov		eax,edi
	pop		ecx
	pop		edi
	pop		ebp
	ret
reStringProc	ENDP

strLenProc	PROC
	push	ebp
	mov		ebp,esp
	push	ebx
	mov		ebx,[ebp+8]
	mov		eax,0
	countbytes:
	cmp		BYTE PTR [ebx],0
	je		endcount
	inc		eax
	inc		ebx
	jmp		countbytes
	endcount:
	pop		ebx
	pop		ebp
	ret
strlenProc	ENDP
END
