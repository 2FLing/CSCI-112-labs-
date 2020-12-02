;This program will caculate volume of a circular cone with
; hegiht h and base radius r.
; Author:  MingkuanPang
; Date:    12/1/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
h		REAL4	1.0
r		REAL4	2.0
three   DWORD	3
volume	REAL4	?

.CODE       
_MainProc    PROC
	fld		r
	fmul	r
	fmul	h
	fldpi
	fmul
	fidiv	three
	fstp	volume
	mov		eax,0
	ret
_MainProc    ENDP
END
