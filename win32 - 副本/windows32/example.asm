; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/24/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
number	DWORD	?
value	DWORD	2

.CODE       
_MainProc    PROC	
	mov		eax,2147483647
	add		eax,100
	ret
_MainProc    ENDP

changeProc	PROC
	push	ebp
	mov		ebp,esp
	push	eax
	mov		eax,[ebp+12]
	mov		[ebp+8],eax
	pop		eax
	pop		ebp
	ret
changeProc	ENDP
END
