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
inprompt	BYTE	"Please enter your binary number",0
result	BYTE	11 DUP(?),0
answer	BYTE	"Convert it to octal number it will be :",0

cbo	MACRO	num,str
	lea		eax,str
	push	eax
	lea		eax,num
	push	eax
	call	cboProc
	add		esp,8
	ENDM
cwtoa	MACRO	num,str
	lea		eax,str
	push	eax
	pushd	num
	call	cwtoaProc
	add		esp,8
	ENDM
.CODE       
_MainProc    PROC	
	input	inprompt,string,30
	cbo		num,string  ;enter a binary num, and it will convert it into octal num and put it in the num
	cwtoa	num,result	;however the num is in hex, so in order to display the num correctly, we use cwtoa here
	output	answer,result ;now it can display whatever is in the num, instead of converting the num to decimal before display it.
	mov		eax,0
	ret
_MainProc    ENDP


;convert byte to octal digits
;oct,byte
cboProc		PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	ebx
	push	ecx
	push	edx
	mov		ebx,[ebp+8];oct
	mov		eax,[ebp+12];byte
	mov		DWORD PTR [ebx],0
	mov		ecx,2
	forloop1:
	mov		edx,1
	shl		edx,cl
	shr		edx,1
	cmp		BYTE PTR [eax],'1'
	jne		nextdigit
	add		DWORD PTR [ebx],edx
	nextdigit:
	inc		eax
	loop	forloop1
	shl		DWORD PTR [ebx],4
	mov		ecx,3
	forloop2:
	mov		edx,1
	shl		edx,cl
	shr		edx,1
	cmp		BYTE PTR [eax],'1'
	jne		nextdigit2
	add		DWORD PTR [ebx],edx
	nextdigit2:
	inc		eax
	loop	forloop2
	shl		DWORD PTR [ebx],4
	mov		ecx,3
	forloop3:
	mov		edx,1
	shl		edx,cl
	shr		edx,1
	cmp		BYTE PTR [eax],'1'
	jne		nextdigit3
	add		DWORD PTR [ebx],edx
	nextdigit3:
	inc		eax
	loop	forloop3

	elsezero:
	pop		edx
	pop		ecx
	pop		ebx
	pop		eax
	pop		ebp
	ret
cboProc		ENDP

;convert a word value to byte value
cwtoaProc	PROC	
	push	ebp
	mov		ebp,esp
	push	eax
	push	ebx
	push	ecx
	push	edx
	mov		ebx,[ebp+8];num
	mov		eax,ebx
	mov		ecx,4
	mov		edx,1000h
	whileloop:
	test	ebx,edx
	jnz		endwhile
	shr		edx,4
	dec		ecx
	rol		ax,4
	jmp		whileloop
	endwhile:
	mov		ebx,eax
	mov		eax,[ebp+12];string
	forloop:
	rol		bx,4
	mov		dx,bx
	and		edx,00000fh
	or		edx,30h
	mov		BYTE PTR [eax],dl
	inc		eax
	loop	forloop
	pop		edx
	pop		ecx
	pop		ebx
	pop		eax
	pop		ebp
	ret
cwtoaProc	ENDP
END