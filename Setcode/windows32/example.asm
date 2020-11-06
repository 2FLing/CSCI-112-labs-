; Author:  MingkuanPang
; Date:    10/29/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
X		  DWORD		5
Y		  DWORD		1
Xmin	  DWORD		2
Ymin	  DWORD		2
Xmax	  DWORD		4
Ymax	  DWORD		4

setCode		Macro	x,y,xmin,ymin,xmax,ymax
	pushd	ymax
	pushd	xmax
	pushd	ymin
	pushd	xmin
	pushd	y
	pushd	x
	call	setCodeProc
	add		esp,24
	ENDM
.CODE       
_MainProc    PROC
	setCode	x,y,xmin,ymin,xmax,ymax
	mov		eax,0
	ret
_MainProc    ENDP

;x,y,xmin,ymin,xmax,ymax
setCodeProc		PROC
	push	ebp
	mov		ebp,esp
	push	ebx
	push	edx
	and		eax,0000h
	mov		ebx,[ebp+8]
	mov		edx,[ebp+12]
	cmp		ebx,[ebp+16]
	jg		ifxmiddle
	mov		al,10h
	jmp		compareY
	ifxmiddle:
	cmp		ebx,[ebp+24]
	jge		ifxlarge
	mov		al,00h
	jmp		compareY
	ifxlarge:
	mov		al,01h
	compareY:
	cmp		edx,[ebp+20]
	jg		ifymiddle
	or		ax,01000h
	jmp		ending
	ifymiddle:
	cmp		edx,[ebp+28]
	jge		ifylarge
	and		ax,000011h
	jmp		ending
	ifylarge:
	or		ax,00100h
	ending:
	pop		edx
	pop		ebx
	pop		ebp
	ret
setCodeProc		ENDP
END
