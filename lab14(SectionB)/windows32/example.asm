; lab14-SectionB
; Author:  MingkuanPang
; Date:    12/3/2020    

.586
.MODEL FLAT
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
Number1	REAL4	175.5
Number2	REAL4	0.09375
Number3	REAL8	-0.0078125
Number4	REAL8	-11.75
Number5	REAL10	3160.0
Number6	REAL10  -1.25
;EX 9.2
fpTemp1	REAL4	9.0
fpTemp2	REAL4	12.0
fpTemp3	REAL4	23.0
fpTemp4	REAL4	24.0
fpTemp5	REAL4	35.0
fpValue	REAL4	0.5
intValue	DWORD	6
.CODE       
_MainProc    PROC
InitializedST:
	finit
	fld		fpTemp5
	fld		fpTemp4
	fld		fpTemp3
	fld		fpTemp2
	fld		fpTemp1
Instructions:
	;fld	st(2)	; 23.0 9.0 12.0 23.0 24.0 35.0 
	;fld	fpValue	 ;0.5 9.0 12.0 23.0 24.0 35.0 
	;fild	intValue ;6.0 9.0 12.0 23.0 24.0 35.0 
	;fldpi		;3.1415926... 9.0 12.0 23.0 24.0 35.0 
	;fst	st(4)	;9.0 12.0 23.0 24.0 9.0 
	;fstp	st(4)	;12.0 23.0 24.0 9.0
	;fst	fpValue	;9.0 12.0 23.0 24.0 35.0  fpValue=9.0
	fistp	intValue	;12.0 23.0 24.0 35.0 intValue=9
	mov		eax,0
	ret
_MainProc    ENDP
END
