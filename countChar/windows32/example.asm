; Example assembly language program
; This program will prompts for and inputs
; a string and a character. Finally, it will return
; the number of occurrences of the character in a string.
; Author:  MingkuanPang
; Date:    11/21/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
stringLen	DWORD	?
string		BYTE	80 DUP (?),0
char		BYTE	5  DUP (?)
strPrompt	BYTE	"Please enter a string",0
charPrompt	BYTE	"Pease enter a character",0
resultLbl	BYTE	"The result is going to be ",0
timesLbl	BYTE	"This character appears in this string:"
times		BYTE	11 DUP (?)
timesLbl2   BYTE	" times.",0

countChar	MACRO	char,string
	lea		eax,string
	push	eax
	mov		al,char
	push	ax
	call	countCharProc
	add		esp,6
	ENDM
.CODE       
_MainProc    PROC
	input	  strPrompt,string,80
	input	  charPrompt,char,5
	countChar char,string
	dtoa	  times,ebx
	output	  resultLbl,timesLbl
	mov			eax,0
	ret
_MainProc    ENDP

countCharProc	PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	edi
	push	ecx
	mov		edi,[ebp+10]
	mov		eax,[ebp+8]
	mov		ebx,0
	checkChar:
	cmp		BYTE PTR [edi],0
	jz		finishCounting
	mov		ecx,1
	cld
	repne	scasb
	jz		found
	
	notFound:
	jmp		checkChar

	found:
	inc		ebx
	jmp		checkChar

	finishCounting:
	pop		ecx
	pop		edi
	pop		eax
	pop		ebp
	ret

countCharProc	ENDP

END
