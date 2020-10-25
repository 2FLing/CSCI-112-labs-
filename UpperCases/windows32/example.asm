; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/24/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
len		DWORD	5
bytArray    BYTE	'a','b','c','d','e',95 DUP(?)
result	BYTE	"the result is ",0

FuctnUpper	MACRO	val1,val2
		lea		eax,val1
		push	eax
		pushd	val2
		call	upper
		add		esp,8
		ENDM
.CODE       

_MainProc    PROC
	FuctnUpper	bytArray,len
	output	result,bytArray
	mov		eax,0
	ret
_MainProc    ENDP

Upper	PROC
	push	ebp
	mov		ebp,esp
	push	ecx
	mov		ecx,[esp+12]
forloop:
	cmp		BYTE PTR [eax],60h
	jl		endiflower
	sub		BYTE PTR [eax],20h
endiflower:
	add		eax,1
	loop	forloop
	pop		ecx
	pop		ebp
	ret
Upper	ENDP
END

