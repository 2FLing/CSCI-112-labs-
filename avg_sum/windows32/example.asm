; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/24/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
times		DWORD	0
nbrArray    DWORD	95 DUP(?)
string	BYTE	30 DUP(?)
avg_str	BYTE	11	DUP(?),0
sum_str	BYTE	11	DUP(?),0
avg		BYTE	"the average is ",0
sum		BYTE	"The sum is ",0
prompt1		BYTE	"Please enter a number (enter 'q' to stop)",0			

.CODE       

_MainProc    PROC
	mov		ebx,0
whileloop:
	input	prompt1,string,30
	cmp		string,'q'
	je		endwhile
	atod	string
	add		ebx,eax
	inc		times
	mov		eax,ebx
	cdq
	idiv	times
	dtoa	avg_str,eax
	dtoa	sum_str,ebx
	output	avg,avg_str
	output	sum,sum_str
	jmp		whileloop
endwhile:
	mov		eax,0
	ret
_MainProc    ENDP
END
