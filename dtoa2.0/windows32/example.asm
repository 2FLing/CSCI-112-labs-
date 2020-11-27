;dtoaProc(source,dest)
;Convert double (source) to string of 11 characters at destination
;address
; Author:  MingkuanPang
; Date:    11/22/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
string		BYTE	11 DUP (?),0
num			DWORD	521
resultLbl	BYTE	"The result will be",0

dtoa	MACRO	source,dest
	push	eax
	lea		eax,dest
	push	eax
	mov		eax,[esp+4]
	mov		eax,source
	push	eax
	call	dtocharProc
	add		esp,8
	pop		eax
	ENDM
.CODE       
_MainProc    PROC
	dtoa		num,string
	output		resultLbl,string
	mov			eax,0
	ret
_MainProc    ENDP

dtocharProc	PROC
	push	ebp
	mov		ebp,esp
	push	edi
	push	eax
	push	ebx
	push	ecx
	push	edx
	pushfd
	mov		eax,[ebp+8]
	cmp		eax,80000000h
	je		Special
	
	InicialString:
	push	eax
	mov		al,' '

	PutSpace:
	mov		edi,[ebp+12]
	mov		ecx,10
	cld		
	rep		stosb
	pop		eax

	mov		ebx,10
	mov		cl,' '

	cmp		eax,0
	jge		Positive
	neg		eax
	mov		cl,'-'
	

	Positive:
	cdq
	div		ebx
	or		dl,30h
	mov		BYTE PTR [edi],dl
	dec		edi
	cmp		eax,0
	je		addSign
	jmp		Positive
	Special:
	mov		edi,[ebp+12]
	mov		BYTE PTR [edi],'-'
	mov		BYTE PTR [edi+1],'2'
	mov		BYTE PTR [edi+2],'1'
	mov		BYTE PTR [edi+3],'4'
	mov		BYTE PTR [edi+4],'7'
	mov		BYTE PTR [edi+5],'4'
	mov		BYTE PTR [edi+6],'8'
	mov		BYTE PTR [edi+7],'3'
	mov		BYTE PTR [edi+8],'6'
	mov		BYTE PTR [edi+9],'4'
	mov		BYTE PTR [edi+10],'7'
	jmp		endProc

	addSign:
	mov		BYTE PTR [edi],cl

	endProc:
	popfd
	pop		edx
	pop		ecx
	pop		ebx
	pop		eax
	pop		edi
	pop		ebp
	ret
dtocharProc	ENDP

END
