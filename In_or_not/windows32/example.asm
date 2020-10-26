; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/24/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
nbrArray	DWORD	90 DUP(?)
number		DWORD	?
prompt1		BYTE	"Please enter a number(enter 'q' to quit)",0
prompt2		BYTE	"This is not in the array",0
string		BYTE	30	DUP(?)
answer		BYTE	11	DUP(?),0
result		BYTE	"That is in the Array in the position of",0
.CODE       

_MainProc    PROC	
	mov		esi,0
loop1:
	input	prompt1,string,30
	cmp		string,'q'
	je		endloop1
	atod	string
	mov		nbrArray[esi*4],eax
	inc		esi
	jmp		loop1
endloop1:
	cmp		esi,0
	je		quitProc
loop2:
	input	prompt1,string,30
	cmp		string,'q'
	je		quitProc
	atod	string
	mov		number,eax
	mov		ecx,esi
	mov		ebx,0
forloop:
	mov		eax,nbrArray[ebx*4]
	cmp		eax,number
	jne		next
	inc		ebx
	dtoa	answer,ebx
	output	result,answer
	jmp		loop2
next:
	inc		ebx
	loop	forloop
	dtoa	answer,number
	output	prompt2,answer
	jmp		loop2
quitProc:
	mov		eax,0
	ret
_MainProc    ENDP
END
