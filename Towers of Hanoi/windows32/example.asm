; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/8/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
prompt	BYTE	"How many disks?",0
number	BYTE	16 DUP(?)
outLbl	BYTE	"Move disk",0
outMsg	BYTE	"from spindle "
source	BYTE	?, 0ah,	0dh
		BYTE	'to spindle '
dest	BYTE	?, 0
.CODE       
_MainProc    PROC
	mov		al,'C'
	push	eax
	mov		al,'B'
	push	eax
	mov		al,'A'
	push	eax
	input	prompt, number, 16
	atod	number
	push	eax
	call	move
	add		esp,16
	mov		eax,0
	ret
_MainProc    ENDP

fctn1   PROC
	push	ebp
	mov		ebp,esp

	ret
fctn1   ENDP
END                           
