; Example assembly language program
; This program will prmopts for and inputs 
; a string and a character and it will shortened
; the string by removing each occurence of the 
; character.
; Author:  MingkuanPang
; Date:    11/19/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
outLbl	BYTE	"The modified string is",0
string	BYTE	"ABCDEFGHIJ",0

.CODE       
_MainProc    PROC
; setup code 1
	;lea		esi,string
	;lea		edi,string+5
	;cld
	;movsb
	;movsb
	;movsb
	;movsb
	;output	outLbl,string	;The output will be ABCDEABCDJ

; setup code 2
	;lea		esi,string
	;lea		edi,string+2
	;cld
	;movsb
	;movsb
	;movsb
	;movsb
	;output	outLbl,string	;The output will be ABABABGHIJ

;setup code 3
	;lea		esi,string+9
	;lea		edi,string+4
	;std
	;movsb
	;movsb
	;movsb
	;movsb
	;output	outLbl,string	;The output will be AGHIJFGHIJ

;setup code 4
	lea		esi,string+9
	lea		edi,string+7
	std
	movsb
	movsb
	movsb
	movsb
	output	outLbl,string	;The output will be ABCDIJIJIJ

	mov		eax,0
	ret
_MainProc    ENDP

END
