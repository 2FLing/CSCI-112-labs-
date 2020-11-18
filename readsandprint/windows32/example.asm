; Example assembly language program
; This program reads input strings and diplay
; all the strings that had been inputed
; Author:  MingkuanPang
; Date:    11/15/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
byteArea	BYTE	1024 DUP(?)
stringIn	BYTE	80	DUP(?)
prompt		BYTE	"Enter your string:",0
prompt2		BYTE	"The strings you entered were:",0
cpyStrings	MACRO source,destination
		lea		eax,destination
		push	eax
		lea		eax,source
		push	eax
		call	cpyStringProc
		add		esp,8
		ENDM

.CODE       
_MainProc    PROC
	inputstr:
	input		prompt,stringIn,80
	cpyStrings	stringIn,byteArea
	cmp			BYTE PTR stringIn[0],'$'
	je			endinput
	jmp			inputstr
	endinput:
	output		prompt2,byteArea
	mov		eax,0
	ret
_MainProc    ENDP

cpyStringProc PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	edi
	pushfd
	mov		esi,[ebp+8]
	mov		edi,[ebp+12]
	cmp		BYTE PTR [esi],'$'
	jne		skipnotnull
	inc		esi
	skipnotnull:
	cmp		BYTE PTR [edi],0
	je		startpoint
	inc		edi
	jmp		skipnotnull
	startpoint:
	cld
	cpystring:
	cmp		BYTE PTR [esi],0
	je		finishcopy
	movsb
	jmp		cpystring
	finishcopy:
	mov		DWORD PTR [edi],13
	inc		edi
	mov		DWORD PTR [edi],10
	mov		esi,[ebp+8]
	cmp		BYTE PTR [esi],'$'
	je		addNull
	jmp		quitcpy
	addNull:
	inc		edi
	mov		BYTE PTR [edi],0
	quitcpy:
	popfd
	pop		edi
	pop		esi
	pop		ebp
	ret
cpyStringProc	ENDP
END
