; Author:  MingkuanPang
; Date:    10/29/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
source		  DWORD		0b70589a4h
dest	  BYTE	9 DUP  (?),0
result	  BYTE	"Convert to ascii the result is:",0
inprompt	  BYTE	"Please enter a hex number:",0
string		BYTE	30	DUP (?)

convertHex		Macro	val1,val2
	lea		eax,val2
	push	eax
	mov		eax,val1
	push	eax
	call	convertHexProc
	add		esp,8
	ENDM
.CODE       
_MainProc    PROC
	input	inprompt,string,30
	atod	string
	mov		source,eax
	convertHex	source,dest
	output	result,dest
	mov		eax,0
	ret
_MainProc    ENDP

;val1,val2(array)
convertHexProc		PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	ecx
	push	ebx
	push	edx
	mov		eax,[ebp+8]
	mov		edx,[ebp+12]
	mov		ecx,8
forloop:
	mov		ebx,eax
	and		ebx,00001111b
	cmp		ebx,9h
	jg		ifchar
	or		bl,30h
	jmp		ending
	ifchar:
	add		bl,'A'-10
	ending:
	mov		[edx+ecx-1],bl
	shr		eax,4
	loop	forloop
	pop		edx
	pop		ebx
	pop		ecx
	pop		eax
	pop		ebp
	ret
convertHexProc		ENDP
END
