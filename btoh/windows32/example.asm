; Author:  MingkuanPang
; Date:    10/29/2020    
;没人看得懂系列......
.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data

string	BYTE	30	DUP(0),0
num		DWORD	0
inprompt	BYTE	"Please enter your octal number",0
result	BYTE	11 DUP(?),0
answer	BYTE	"Convert it to binary number it will be :",0

otob	MACRO	num,str
		lea		eax,str
		push	eax
		pushd	num
		call	otobProc
		add		esp,8
		ENDM

btoh	MACRO	num,str ;convert byte value to dword value with decimal value instead of changing the num to hex
		lea		eax,str
		push	eax
		lea		eax,num
		push	eax
		call	btohProc
		add		esp,8
		ENDM
.CODE       
_MainProc    PROC	
	input	inprompt,string,30
	atod	string
	btoh	num,string
	otob	num,result
	output	answer,result
	mov		eax,0
	ret
_MainProc    ENDP
;num string
otobProc	PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	esi
	push	ecx
	push	ebx
	push	edx
	mov		eax,[ebp+8]
	mov		esi,[ebp+12]
	and		eax,0000fffh
	mov		ecx,3
	rol		ax,4
	forloop:
	rol		ax,4
	mov		ebx,eax
	and		bx,000fh
	rol		bx,13
	mov		edx,ecx
	mov		ecx,3
	forloop2:
	rol		bx,1
	jnc		elsezero
	mov		BYTE PTR [esi],'1'
	jmp		nextbit
	elsezero:
	mov		BYTE PTR [esi],'0'
	nextbit:
	inc		esi
	loop	forloop2
	nextbyte:
	mov		ecx,edx
	loop	forloop
	pop		edx
	pop		ebx
	pop		ecx
	pop		esi
	pop		eax
	pop		ebp
	ret
otobProc	ENDP

btohProc	PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	esi
	push	ebx
	mov		eax,[ebp+8]
	mov		esi,[ebp+12]
	cmp		BYTE PTR [esi],0
	je		quitproc
	mov		DWORD PTR [eax],0
	mov		ebx,0
	whileloop:
	cmp		BYTE PTR [esi],0
	je		quitproc
	cmp		BYTE PTR [esi],'0'
	je		nextbyte
	mov		bl,BYTE PTR [esi]
	sub		bl,30h
	add		DWORD PTR [eax],ebx
	shl		DWORD PTR [eax],4
	nextbyte:
	inc		esi
	jmp		whileloop
	quitproc:
	shr		DWORD PTR [eax],4
	pop		ebx
	pop		esi
	pop		eax
	pop		ebp
	ret
btohProc	ENDP
END