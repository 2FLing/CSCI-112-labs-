; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/24/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
nbrArray	DWORD	90 DUP(?)
nbrele		DWORD	?
number		DWORD	?
prompt1		BYTE	"Please enter a number(enter 'q' to quit)",0
prompt2		BYTE	"This is not in the array",0
string		BYTE	30	DUP(?)
answer		BYTE	11	DUP(?),0
result		BYTE	"That is in the Array in the position of",0

Insert	MACRO	val1
	lea		eax,val1
	push	eax
	call	InsertProc
	add		esp,4
	ENDM

check	MACRO	val1,val2,val3
	pushd	val3
	pushd	val2
	lea		eax,val1
	push	eax
	call	CheckProc
	add		esp,16
	ENDM
.CODE       

_MainProc    PROC	
	Insert	nbrArray
whileloop:
	input	prompt1,string,30
	cmp		string,71h
	je		quit
	atod	string
	mov		number,eax
	check	nbrArray,number,nbrele
	cmp		eax,0
	je		notexist
	dtoa	answer,eax
	output	result,answer
	jmp		whileloop
notexist:
	dtoa	answer,number
	output	prompt2,answer
	jmp		whileloop	
quit:
	mov		eax,0
	ret
_MainProc    ENDP

;InsertProc(&Array)
InsertProc	PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	esi
	push	edx
	mov		esi,[ebp+8]
	mov		edx,0
insertloop:
	input	prompt1,string,30
	cmp		string,'q'
	je		quitloop
	atod	string
	mov		[esi],eax
	inc		edx
	add		esi,4
	jmp		insertloop
quitloop:
	mov		nbrele,edx
	pop		edx
	pop		esi
	pop		eax
	pop		ebp
	ret
InsertProc	ENDP

;check(array,num,len)
CheckProc	PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	ebx
	push	ecx
	mov		esi,[ebp+8]
	mov		ebx,[ebp+12]
	mov		ecx,[ebp+16]
	mov		eax,0
forloop:
	cmp		ebx,[esi]
	jne		next
	mov		eax,[ebp+16]
	sub		eax,ecx
	inc		eax
	jmp		quitcheckProc
next:
	add		esi,4
	loop	forloop
quitcheckProc:
	pop		ecx
	pop		ebx
	pop		esi
	pop		ebp
	ret
CheckProc	ENDP
END

