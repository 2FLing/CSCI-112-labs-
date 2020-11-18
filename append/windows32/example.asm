; Example assembly language program
; This program will append null-terminated
;string to the end of another.
; Author:  MingkuanPang
; Date:    11/17/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
string1	BYTE	80	DUP (?)
string2	BYTE	80	DUP (?)
str1Len	DWORD	?
str2Len	DWORD	?
inputPrompt		BYTE	"Please enter a string:",0
inputPrompt2	BYTE	"Please enter another string:",0
resultLbl		BYTE	"The result will be: ",0

append	MACRO	string1,string2
	lea		eax,string2
	push	eax
	lea		eax,string1
	push	eax
	call	appendProc
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
	input	inputPrompt,string1,80
	input	inputPrompt2,string2,80
	strLen	string1
	mov		str1Len,eax
	strLen	string2
	mov		str2Len,eax
	append	string1,string2
	output	resultLbl,string1
	mov		eax,0
	ret
_MainProc    ENDP

appendProc	PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	edi
	mov		esi,[ebp+12]
	mov		edi,[ebp+8]
	add		edi,str1Len
	mov		ecx,str2Len
	cld
	rep		movsb
	pop		edi
	pop		esi
	pop		ebp
	ret
appendProc	ENDP


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
