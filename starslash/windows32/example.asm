; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    11/12/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data

string		BYTE	80 DUP (?)
prompt		BYTE	"the result is:",0
starSlash	MACRO	string
	lea		eax,string
	push	eax
	call	starSlashProc
	add		esp,4
	ENDM

.CODE       
_MainProc    PROC
	starSlash	string
	output	prompt,string
	mov		eax,0
	ret
_MainProc    ENDP

starSlashProc	PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	ecx
	pushfd
	mov		esi,[ebp+8]
	mov		edi,esi
	add		edi,2
	mov		ecx,78
	mov		BYTE PTR [esi],'*'
	mov		BYTE PTR [esi+1],'/'
	cld
	writestarslash:
	movsb
	loop	writestarslash
	mov		BYTE PTR [esi],0
	popfd
	pop		ecx
	pop		esi
	pop		ebp
	ret
starSlashProc	ENDP	
END
