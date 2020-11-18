; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    11/12/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
prompt1		BYTE	"Please enter a string",0
instring	BYTE	30 DUP (?),0
outstr		BYTE	30 DUP (?),0
prompt2		BYTE	"The string you input is:",0

cpystr MACRO orinstr,cpystr
	lea		eax,cpystr
	push	eax
	lea		eax,orinstr
	push	eax
	call	cpystrProc
	add		esp,8
	ENDM

.CODE       
_MainProc    PROC
	input	prompt1,instring,30
	cpystr	instring,outstr
	output	prompt2,outstr
	mov		eax,0
	ret
_MainProc    ENDP
;source,destination
cpystrProc	PROC
	push	ebp
	mov		ebp,esp
	push	edi
	push	esi
	pushfd
	mov		esi,[ebp+8]
	mov		edi,[ebp+12]
	whileloop:
	cmp		BYTE PTR [esi],0
	je		endloop
	cld
	movsb
	jmp		whileloop
	endloop:
	popfd
	pop		esi
	pop		edi
	pop		ebp
	ret
cpystrProc	ENDP
END
