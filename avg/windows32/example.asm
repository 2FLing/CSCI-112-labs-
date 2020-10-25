; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/24/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
len		DWORD	?
nbrArray    DWORD	95 DUP(?)
string	BYTE	30 DUP(?)
answer	BYTE	11	DUP(?),0
result		BYTE	"the average is ",0
prompt1		BYTE	"Please enter a number",0			
prompt2		BYTE	"How many number you want to input?",0

Average	MACRO	array,len
	pushd	len
	lea		eax,nbrArray
	push	eax
	call	AverageProc
	add		esp,8
	ENDM

.CODE       

_MainProc    PROC
	input	prompt2,string,30
	atod	string
	mov		len,eax

	mov		ecx,eax
	lea		ebx,nbrArray
forloop:
	input	prompt1,string,30
	atod	string
	mov		[ebx],eax
	add		ebx,4
	loop	forloop

	Average	nbrArray,len
	dtoa	answer,eax
	output	result,answer
	mov		eax,0
	ret
_MainProc    ENDP

;input(Array,number)
AverageProc	PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	ecx
	push	ebx
	mov		esi,[ebp+8]
	mov		ecx,[ebp+12]
	mov		ebx,ecx
	mov		eax,0
forloop:
	add		eax,[esi]
	add		esi,4
	loop	forloop
	cdq		
	idiv	ebx
	pop		ebx
	pop		ecx
	pop		esi
	pop		ebp
	ret
AverageProc	ENDP
END