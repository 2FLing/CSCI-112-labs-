; Author:  MingkuanPang
; Date:    10/29/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data

odd		MACRO	number
	mov		eax,number
	push	eax
	call	oddProc
	add		esp,4
	ENDM
.CODE       
_MainProc    PROC
	mov		eax,1679
	odd		eax
	mov		eax,0
	ret
_MainProc    ENDP

oddProc		PROC
	push	ebp
	mov		ebp,esp
	mov		eax,[ebp+8]
	and		eax,0001b
	cmp		eax,1
	jne		notodd
	mov		eax,-1h
	jmp		ending
	notodd:
	mov		eax,0
	ending:
	pop		ebp
	ret
oddProc		ENDP
END