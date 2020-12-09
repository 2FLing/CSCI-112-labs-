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

;mov(num,'A','B','C')
move   PROC
	push	ebp
	mov		ebp,esp
	push	eax
	push	ebx
	mov		eax,[ebp+8]
	cmp		eax,1
	jne		moreThanOne
	mov		ebx,[ebp+12]
	mov		source,bl
	mov		ebx,[ebp+20]
	mov		dest,bl
	output	outLbl,outMsg
	jmp		finishMoving

	moreThanOne:
	;mov	n-1 disks	from A to B move(n-1,A,C,B)
	dec		eax
	mov		bl,[ebp+16]
	push	ebx
	mov		bl,[ebp+20]
	push	ebx
	mov		bl,[ebp+12]
	push	ebx
	push	eax
	call	move
	add		esp,16

	;mov	bottom disk	from A to C move(1,A,B,C)
	mov		bl,[ebp+20]
	push	ebx
	mov		bl,[ebp+16]
	push	ebx
	mov		bl,[ebp+12]
	push	ebx
	mov		ebx,1
	push	ebx
	call	move
	add		esp,16

	;mov	n-1 disk from B to C mov(n-1,B,A,C)
	mov		bl,[ebp+20]
	push	ebx
	mov		bl,[ebp+12]
	push	ebx
	mov		bl,[ebp+16]
	push	ebx
	push	eax
	call	move
	add		esp,16

	finishMoving:
	pop		ebx
	pop		eax
	pop		ebp
	ret
move   ENDP
END                           
