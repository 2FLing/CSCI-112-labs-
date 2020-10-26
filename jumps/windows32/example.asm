; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/24/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
addrStore	DWORD	?		
.CODE       

_MainProc    PROC	
doAgain:
	mov		eax,0
	mov		eax,0
	mov		eax,0
	jmp		doAgain	;short jump
	;	200 instructions
	;  ...
	;  ...
	;  ...
	jmp		doAgain	;near jump
	mov		eax,0
	mov		eax,0
	jmp		addrStore ;memory indrect
	mov		eax,0
	mov		eax,0
	jmp		eax		;register indrect
	mov		eax,0
	mov		eax,0
	jmp		DWORD	PTR		[edi]	;memory indrect
	mov		eax,0
	ret
_MainProc    ENDP
END
