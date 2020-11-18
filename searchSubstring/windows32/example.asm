; Example assembly language program
; This program search a substring from a string
;It will print the substring if it be found,
;otherwise it will print fail finding substring.
; all the strings that had been inputed
; Author:  MingkuanPang
; Date:    11/15/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
string		BYTE	80 DUP (?)
keyString	BYTE	80 DUP (?)
prompt1		BYTE	"Please enter a string:",0
prompt2		BYTE	"please enter the key string",0
searchLbl	BYTE	"Search results:",0
notfound	BYTE	"The key string is not found",0
success		BYTE	"The key starts from position:"
position	BYTE	11 DUP (?),0
stringLen		DWORD	?
keyStringLen	DWORD	?
lastPos			DWORD	?
strLen	MACRO	str
	lea		eax,str
	push	eax
	call	strLenProc
	add		esp,4
	ENDM

.CODE       
_MainProc    PROC
	input		prompt1,string,80
	strlen		string	
	mov			stringLen,eax
	input		prompt2,keyString,80
	strlen		keystring	
	mov			keyStringLen,eax
	mov			eax,stringLen
	sub			eax,keyStringLen
	inc			eax
	mov			lastPos,eax
	mov			eax,1
	searchByte:
	cmp			eax,lastPos
	jg			fail
	lea			esi,string
	add			esi,eax
	dec			esi
	lea			edi,keyString
	cld
	mov			ecx,KeyStringLen
	repe		cmpsb
	jz			found
	inc			eax
	jmp			searchByte
	found:
	dtoa		position,eax
	output		searchLbl,success
	jmp			endprogram
	fail:
	output		searchLbl,notfound
	endprogram:
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
