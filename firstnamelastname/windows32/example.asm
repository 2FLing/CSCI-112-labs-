; Example assembly language program
; This program will prmopts for and inputs 
; a person`s name in the "lastname firstname"
; format, a comma or space separate the names
; originally and there is no characters following the 
; firstname and it will build the name in a new format
; with "firstname lastname".
; Author:  MingkuanPang
; Date:    11/17/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
firstName	BYTE	80	DUP (?)
lastName	BYTE	80	DUP (?)
sbName		BYTE	80  DUP (?)
firstNameLen	DWORD	?
lastNameLen		DWORD	?
nameLen			DWORD	?
inputPrompt		BYTE	"Please enter you name (lastName ,/' ' firstname):",0
resultLbl		BYTE	"The result will be: ",0

fixName	MACRO	name
	lea		eax,name
	push	eax
	call	fixNameProc
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
	input	inputPrompt,sbName,80
	strLen	sbName
	mov		nameLen,eax
	fixName	sbName
	output	resultLbl,sbName
	mov		eax,0
	ret
_MainProc    ENDP

fixNameProc		PROC
	push	ebp
	mov		ebp,esp
	push	edi
	push	esi
	push	eax
	push	ebx
	push	ecx
	mov		edi,[ebp+8]
	mov		al,','
	mov		ecx,nameLen
	cld
	repne	scasb
	cmp		ecx,0
	jnz		getLenOffirstNlast
	mov		edi,[ebp+8]
	mov		al,' '
	mov		ecx,nameLen
	repne	scasb
	getLenOffirstNlast:
	inc		ecx
	mov		eax,nameLen
	sub		eax,ecx
	mov		lastNameLen,eax
	inc		eax
	mov		ebx,nameLen
	sub		ebx,eax
	mov		firstNameLen,ebx
	
	getLastName:
	lea		edi,lastName
	mov		esi,[ebp+8]
	mov		ecx,lastNameLen
	cld
	rep		movsb

	getFirstName:
	inc		esi
	lea		edi,firstName
	mov		ecx,firstNameLen
	cld
	rep		movsb

	fix:
	mov		edi,[ebp+8]
	lea		esi,firstName
	mov		ecx,firstNameLen
	cld
	rep		movsb	
	mov		BYTE PTR [edi],' '
	inc		edi
	lea		esi,lastName
	mov		ecx,lastNameLen
	cld
	rep		movsb
	pop		ecx
	pop		ebx
	pop		eax
	pop		esi
	pop		edi
	pop		ebp
	ret
fixNameProc		ENDP

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
