; convert byte to ascii
; Author:  MingkuanPang
; Date:    11/06/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
num		DWORD	?
Binstr  BYTE	32	DUP(?),0
answer	BYTE	"Convert it to binary num, it is going to be: ",0
string	BYTE	30  DUP(?)
inputPrompt  BYTE	"Please enter a number: ",0
cba		MACRO  num,Binstr

		lea		eax,Binstr
		push	eax
		mov		eax,num
		push	eax
		call	cbaProc
		add		esp,8
		ENDM

atoh	MACRO	string,num
		
		lea		eax,num
		push	eax
		lea		eax,string
		push	eax
		call	atohProc
		add		esp,8
		ENDM
.CODE       
_MainProc    PROC
	input	inputPrompt,string,30
	atod	string
	mov		num,eax
	cba		num,Binstr
	output	answer,Binstr
	mov		eax,0
	ret
_MainProc    ENDP

;cba	num,binstr
cbaProc		PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	ebx
	push	ecx
	mov		eax,[ebp+8]	;num
	mov		ebx,[ebp+12] ;address of the string array
	mov		esi,0
	mov		ecx,32
	forloop:
	rol		eax,1
	jc		addOne
	mov		BYTE PTR [ebx],'0'
	jmp		nextbyte
	addone:
	mov		BYTE PTR [ebx],'1'
	nextbyte:
	inc		ebx
	loop	forloop
	pop		ecx
	pop		ebx
	pop		eax
	pop		ebp
	ret
cbaProc		ENDP

; Convert ascii to dword
; not useful in this project at all
atohProc	PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	ebx
	push	esi
	push	edx
	mov		esi,[ebp+8] ;string
	mov		edx,[ebp+12] ;num
	mov		eax,0
	whileloop:
	cmp		BYTE PTR [esi],'0'
	jl		endloop
	cmp		BYTE PTR [esi],'9'
	jg		endloop
	mov		bl,BYTE PTR [esi]
	and		ebx,00000000Fh
	imul	eax,10h
	add		eax,ebx
	inc		esi
	jmp		whileloop
	endloop:
	mov		DWORD PTR [edx],eax
	pop		edx
	pop		esi
	pop		ebx
	pop		eax
	pop		ebp
	ret
atohProc	ENDP
END
