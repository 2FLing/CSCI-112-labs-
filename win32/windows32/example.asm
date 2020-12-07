;some SSE instructions
; Author:  MingkuanPang
; Date:    12/6/2020    

.586
.MODEL FLAT
INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
a		REAL4	2.0
b		REAL4	-1.0
c		REAL4	-15.0
discr	REAL4	?
four	REAL4	4.0
.CODE       
_MainProc    PROC
	movss	xmm0,b	;copy b
	mulss	xmm0,xmm0	;b*b
	movss	xmm1,a
	mulss	xmm1,four
	mulss	xmm1,c
	subss	xmm0,xmm1
	sqrtss	xmm0,xmm0
	movss	discr,xmm0
	mov			eax,0
	ret
_MainProc    ENDP
END
