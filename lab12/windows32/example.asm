; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    11/12/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data

.CODE       
_MainProc    PROC	
;7.1.1
;a)After: BX:3000 SF:0 ZF:0
	mov		bx,-1419	;FA75h
	mov		cx,3102h
	and		bx,cx

;b)After: BX:FB77 SF:1 ZF:0
	mov		bx,-1419
	or		bx,cx

;c)After: BX:CB77 SF:1 ZF:0
	mov		bx,-1419
	xor		bx,cx

;d)After: BX:058A
	mov		bx,-1419
	not		bx

;e)After: AX:0005 SF:1 ZF:0
	mov		ax,-1419
	and		ax,000fh

;f)After: AX:FFF5 SF:1 ZF:0
	mov		ax,-1419
	or		ax,0fff0h

;g)After: AX:058A SF:0 ZF:0
	mov		ax,-1419
	xor		ax,0ffffh

;h)After: AX:FA75 SF:0 ZF:0
	mov		ax,-1419
	test	ax,0004h

;i)After: CX:7145
	mov		cx,-28998	;8EBAh
	not		cx

;j)After: CX:EFFA SF:1 ZF:0
	mov		cx,-28998
	or		cx,-4622	;EDF2h

;k)After: CX:8CB2 SF:1 ZF:0
	mov		cx,-28998
	and		cx,-4622

;l)After: CX:6348 SF:0 ZF:0
	mov		cx,-28998
	xor		cx,-4622

;m)After: CX:8EBA SF:1 ZF:0
	mov		cx,-28998
	test	cx,-4622

;n)After: DX:495C
	mov		dx,-4622
	not		dx

;o)After: DX:F6EB SF:1 ZF:0
	mov		dx,-4622
	or		dx,25800

;p)After: DX:2480 SF:0 ZF:0
	mov		dx,-4622
	and		dx,25800

;q)After: DX:D26B SF:1 ZF:0
	mov		dx,-4622
	xor		dx,25800

;r)After: DX:B6A3 SF:0 ZF:0
	mov		dx,-4622
	test	dx,25800

;7.2.1

;a)After: AX:516A CF:1 OF:1
	mov	ax,-22347	;A8B5
	shl	ax,1

;b)After: AX:545A CF:1 OF:1
	mov	ax,-22347
	shr	ax,1

;c)After: AX:D45A CF:1 OF:0
	mov	ax,-22347
	sar	ax,1

;d)After: AX:516B CF:1
	mov	ax,-22347
	rol	ax,1

;e)After: AX:D45A CF:1
	mov	ax,-22347
	ror	ax,1

;f)After: AX:8B50 CF:0
	mov	ax,-22347
	mov	cl,04h
	sal	ax,cl

;g)After: AX:0A8B CF:0
	mov	ax,-22347
	shr ax,4

;h)After: AX:FA8B CF:0
	mov	ax,-22347
	mov	cl,04h
	sar	ax,cl

;i)After: AX:8B5A CF:0
	mov	ax,-22347
	mov	cl,04h
	rol	ax,cl

;j)After: AX:5A8B CF:0
	mov	ax,-22347
	ror	ax,4

;k)After: AX:5A6B CF:1
	mov	ax,-22347
	stc 
	rcl	ax,1

;l)After: AX:545A CF:1
	mov	ax,-22347
	clc
	rcr	ax,1

;m)	After: BX:75D0 CF:0
	mov	bx,-28998 ;8EBAh
	shl	bx,3

;n)After: BX:11D7 CF:0
	mov	bx,-28998
	shr bx,3

;o)After: BX:75D0 CF:0
	mov	bx,-28998
	sal	bx,3

;p)After: BX:F1D7 CF:0
	mov	bx,-28998
	sar	bx,3

	mov		eax,0
	ret
_MainProc    ENDP
END
