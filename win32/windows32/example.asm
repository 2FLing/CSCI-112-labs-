;dtoaProc(source,dest)
;Convert double (source) to string of 11 characters at destination
;address
; Author:  MingkuanPang
; Date:    11/22/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack
.DATA	; reserve storage for data
realNum		REAL4 -58.5
.CODE       
_MainProc    PROC
	mov			eax,0
	ret
_MainProc    ENDP
END
