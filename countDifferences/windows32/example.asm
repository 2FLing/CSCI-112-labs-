; Example assembly language program
; This program will prompts for and inputs
; two strings,each a null-terminated string.
; The procedure will return  the number of 
; position where the characterin stirng1
; differs from the corresponding character
; in string2
; Author:  MingkuanPang
; Date:    11/21/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
firstString		BYTE	80 DUP (?)
secondString	BYTE	80 DUP (?)
Position		BYTE	11 DUP (?)
firstPrompt		BYTE	"Please enter first string",0
secondPrompt	BYTE	"Please enter second string",0
resultLbl		BYTE	"The result is: ",0
PositionLbl		BYTE	"The differences appears in these positions: "
Positions		BYTE	80 DUP (?)
PositionLbl2	BYTE	"in the first string.",0

countDifferences MACRO	stirng1,string2
	lea		eax,string2
	push	eax
	lea		eax,stirng1
	push	eax
	call	countDifferencesProc
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
	input				firstPrompt,firstString,80
	input				secondPrompt,secondString,80
	countDifferences	firstString,secondString
	output				resultLbl,positionLbl
	mov					eax,0
	ret
_MainProc    ENDP

countDifferencesProc PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	ecx
	push	ebx
	push	esi
	push	edi
	mov		edi,[ebp+8]
	mov		esi,[ebp+12]
	mov		eax,0
	mov		ebx,0
	checkNull:
	cmp		BYTE PTR [edi],0
	jz		finishCounting
	cmp		BYTE PTR [esi],0
	jz		finishCounting

	startCounting:
	inc		eax
	mov		ecx,1
	cld
	repe	cmpsb
	jnz		count

	skip:
	jmp		checkNull

	count:
	or		eax,30h
	mov		BYTE PTR [Positions+ebx],al
	inc		ebx
	mov		BYTE PTR [Positions+ebx],' '
	inc		ebx
	sub		eax,30h
	jmp		checkNull

	finishCounting:
	pop		edi
	pop		esi
	pop		ebx
	pop		ecx
	pop		eax
	pop		ebp
	ret
countDifferencesProc ENDP

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
