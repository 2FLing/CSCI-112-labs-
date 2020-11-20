; Example assembly language program
; This program will prmopts for and inputs 
; a string and a character and it will shortened
; the string by removing each occurence of the 
; character.
; Author:  MingkuanPang
; Date:    11/19/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
string	BYTE	80	DUP (?)
char	BYTE	5	DUP (?)
stringPrompt	BYTE	"Please enter a string:",0
charPrompt		BYTE	"Please enter the character that you want to remove",0
resultLbl		BYTE	"The new string will be: ",0

removeChar	MACRO	string,char
	mov		eax,0
	mov		al,char
	push	eax
	lea		eax,string
	push	eax
	call	removeCharProc
	add		esp,8
	ENDM

strLen	MACRO	string
	lea		eax,string
	push	eax
	call	strLenProc
	add		esp,4
	ENDM
.CODE       
_MainProc    PROC
	input	stringPrompt,string,80
	input	charPrompt,char,5
	removeChar string,char
	output	resultLbl,string
	mov		eax,0
	ret
_MainProc    ENDP

removeCharProc	PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	edi
	push	eax
	mov		esi,[ebp+8]
	mov		edi,[ebp+8]
	mov		eax,[ebp+12]
	IfIsChar:
	cmp		BYTE PTR [esi],0

	jz		finishRemoving
	cmp		BYTE PTR [esi],al
	jz		isChar

	isNotChar:
	movsb
	jmp		IfIsChar

	isChar:
	inc		esi
	cmp		BYTE PTR [esi],al
	jz		isChar
	jmp		IfIsChar

	finishRemoving:
	mov		BYTE PTR [edi],0
	pop		eax
	pop		edi
	pop		esi
	pop		ebp
	ret
removeCharProc	ENDP

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
