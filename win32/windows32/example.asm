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
wrold	BYTE	80	DUP (?)
test2	BYTE	"hello"
test1	BYTE	"hollo"
stringPrompt	BYTE	"Please enter a string:",0
charPrompt		BYTE	"Please enter the character that you want to remove",0
resultLbl		BYTE	"The new string will be: ",0



strLen	MACRO	string
	lea		eax,string
	push	eax
	call	strLenProc
	add		esp,4
	ENDM
.CODE       
_MainProc    PROC
	lea		esi,test2
	lea		edi,test1
	mov		ecx,1
	cld
	repne	cmpsb
	mov		eax,0
	ret
_MainProc    ENDP


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
