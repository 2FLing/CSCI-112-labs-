; Example assembly language program
; This program will find and print 
;the position of the first occurrence of a character
;om a null-terminated string.
; all the strings that had been inputed
; Author:  MingkuanPang
; Date:    11/17/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
char	BYTE	5	DUP (?)
string	BYTE	80	DUP (?)
strLen	DWORD	?
inputPrompt		BYTE	"Please enter a string:",0
inputPrompt2	BYTE	"Please enter a character:",0
resultLbl		BYTE	"The result will be: ",0
position		BYTE	11 DUP (?),0
notFoundLbl		BYTE	"This character was not found in the string",0
find_pos MACRO	char,string
	lea		eax,string
	push	eax
	mov		al,char
	push	ax
	call	find_posProc
	add		esp,6
	ENDM
.CODE       
_MainProc    PROC
	input		inputPrompt,string,80
	input		inputprompt2,char,5
	lea			eax,string
	push		eax
	call		strLenProc
	add			esp,4
	mov			strLen,eax	
	find_pos	char,string
	cmp			eax,0
	jz			charNotFound
	dtoa		position,eax
	output		resultLbl,position
	jmp			endprogram
	charNotFound:
	output		resultLbl,notFoundLbl
	endprogram:
	mov			eax,0
	ret
_MainProc    ENDP
find_posProc	PROC
	push	ebp
	mov		ebp,esp
	push	edi
	push	ecx
	mov		edi,[ebp+10]
	mov		al,[ebp+8]
	mov		ecx,strLen
	cld
	repne	scasb
	cmp		BYTE PTR [edi],0
	jz		fail
	sub		strLen,ecx
	mov		eax,strLen
	jmp		endFindPos
	fail:
	mov		eax,0
	endFindPos:
	pop		ecx
	pop		edi
	pop		ebp
	ret	
find_posProc	ENDP

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
