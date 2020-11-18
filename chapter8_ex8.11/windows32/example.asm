; Example assembly language program
; This program search a substring from a string
;It will print the substring if it be found,
;otherwise it will print fail finding substring.
; all the strings that had been inputed
; Author:  MingkuanPang
; Date:    11/15/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
;source		BYTE	"brown"
;dest		BYTE	"brine"
;source		BYTE	"broke"
;dest		BYTE	"spoke"
source		BYTE	"broke"
dest		BYTE	"bloke"
.CODE       
_MainProc    PROC
	;lea		esi,source
	;lea		edi,dest
	;mov		ecx,5
	;mov		ecx,3
	;cld
	;repne	cmpsb
	;repe	cmpsb
	;mov	al,'w'
	;mov	al,'n'
	;mov	al,'*'
	;repne	scasb
	;rep	stosb
	;for6:
	;lodsb
	;inc	al
	;stosb
	;loop	for6
	;rep	movsb
	;lea		esi,source+4
	;lea		edi,dest+4
	;std
	;mov		ecx,3
	;rep		movsb
	;lea		esi,source
	;lea		edi,dest
	;cld
	;mov		ecx,5
	;repne		cmpsb
	lea			esi,source+4
	lea			edi,dest+4
	std
	mov			ecx,5
	repe		cmpsb
	mov		eax,0
	ret
_MainProc    ENDP
END
