; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/21/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
x     DWORD ?
y     DWORD ?
z     DWORD ?
minimum     DWORD ?
maximum     DWORD ?
nbrArray    DWORD 25,47,95,50,16,95 DUP(?)

prompt1 BYTE    "Please enter the first number",0
prompt2 BYTE    "Please enter the second number",0
prompt3 BYTE    "Please enter the third number",0
prompt4	BYTE	"The maximum number is",0
prompt5 BYTE	"The minimum number is",0
string     BYTE    30 DUP (?)
answer  BYTE    "The result is:",0
result    BYTE    11 DUP (?),   0 
max_num		BYTE	11 DUP (?),		0
min_num		BYTE	11 DUP (?),		0
.CODE       
_MainProc    PROC
	lea		eax,maximum
	push	eax
	lea		eax,minimum
	push	eax
	pushd	5
	lea		eax,nbrArray
	push	eax
	call	fctn1
	add		esp,16
	dtoa	max_num,maximum
	dtoa	min_num,minimum
	output	prompt4,max_num
	output	prompt5,min_num
	mov		eax,0
	ret
_MainProc    ENDP
;void minMax(int arr[], int count, int& min, int& max);
;Set min to smallest value in arr[0],......., arr[count-1]
;Set max to largest value in arr[0],.......,arr[count-1]
fctn1   PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	ebx
	push	ecx
	push	edx
	push	eax
	mov		esi,[ebp+8]
	mov		ecx,[ebp+12] ;set ecx to count
	mov		ebx,[ebp+16] ;set ebx to minimum
	mov		edx,[ebp+20] ;set edx to maximum
	mov		DWORD PTR [ebx],7FFFFFFFh
	mov		DWORD PTR [edx],80000000h
forloop:
	mov		eax,[esi]
	cmp		eax,[ebx]
	jnl		endifmin
	mov		[ebx],eax
endifmin:
	cmp		eax,[edx]
	jng		endforloop
	mov		[edx],eax
endforloop:
	add		esi,4
	loop	forloop
	pop		eax
	pop		edx
	pop		ecx
	pop		ebx
	pop		esi
	pop		ebp
	ret
fctn1   ENDP
END                           
