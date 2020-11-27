;Translate lower case letters to upper case; don`t change lower
; case letters and digits. Translate other characters to spaces.
; Author:  MingkuanPang
; Date:    11/22/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
strPrompt	BYTE	"Please enter a string ",0
resultLbl	BYTE	"The result will be",0
string		BYTE	80 DUP (?),0
table		BYTE	48 DUP (' '),"0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ"
			BYTE	"[\]^_'ABCDEFGHIJKLMNOPQRSTUVWXYZ", 134 DUP (' ')

Tolower	MACRO	string
	lea		eax,string
	push	eax
	call	TolowerProc
	add		esp,4
	ENDM

strLen	MACRO	string
	lea		eax,string
	push	eax
	call	strLenProc
	add		esp,4
	ENDM
.CODE       
_MainProc    PROC
	input		strPrompt,string,80
	Tolower		string
	output		resultLbl,string
	mov			eax,0
	ret
_MainProc    ENDP

TolowerProc		PROC
	push		ebp
	mov			ebp,esp
	push		esi
	push		edi
	push		ecx
	push		eax
	push		ebx
	lea			ebx,table
	mov			esi,[ebp+8]
	mov			edi,[ebp+8]
	push		esi
	call		strLenProc
	add			esp,4
	mov			ecx,eax
	
	TranslateChar:
	lodsb
	xlat
	stosb
	loop	TranslateChar

	endOfProc:
	pop			ebx
	pop			eax
	pop			ecx
	pop			edi
	pop			esi
	pop			ebp
	ret
TolowerProc		ENDP


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
