; Example assembly language program
; This program will prmopts for and inputs 
; a sentence and a word and it will shortened
; the sentence by removing each occurence of the 
; word.
; Author:  MingkuanPang
; Date:    11/20/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
sentence	BYTE	80	DUP (?)
aWord		BYTE	80	DUP (?)
wordLen		DWORD	?

sentencePrompt	BYTE	"Please enter a sentence:",0
wordPrompt		BYTE	"Please enter a word that you want to remove",0
resultLbl		BYTE	"The new sentence will be: ",0
removeWord	MACRO	sentence,word
	lea		eax,aWord
	push	eax
	lea		eax,sentence
	push	eax
	call	removeWordProc
	add		esp,8
	ENDM

strLen	MACRO	string
	lea		eax,string
	push	eax
	call	strLenProc
	add		esp,4
	ENDM
.CODE       
_MainProc    PROC
	input		sentencePrompt,sentence,80
	input		wordPrompt,aWord,80
	strLen		aWord
	mov			wordLen,eax
	removeWord	sentence,aWord
	output		resultLbl,sentence
	mov			eax,0
	ret
_MainProc    ENDP

removeWordProc	PROC
	push	ebp
	mov		ebp,esp
	push	esi
	push	edi
	push	ecx
	push	eax
	push	ebx
	push	edx
	mov		esi,[ebp+8]	;initialized esi to sentence
	mov		eax,0
	mov		ebx,0

	checkSpace:
	cmp		BYTE PTR [esi],0	;check if is the end of the sentence
	jz		isSpace				;if is check if the previous word needs to be removed
	cmp		BYTE PTR [esi],' '	; check if is space, if it is, then check if the word needs to be removed
	jnz		notSpace			;otherwise keep going
	
	isSpace:
	cmp		ebx,0			;here, ebx is the length of the current word that has been read
	jz		finishRemoving	;if ebx is 0, it means the last word is done with checking
	sub		esi,ebx			;otherwise set esi back to the beginning letter of the word
	mov		edi,[ebp+12]	;set edi to be the word that needs to be removed
	mov		ecx,wordLen		;set ecx to be the length of the removing word of course
	cld
	repe	cmpsb			;check if the word needs to be remove
	jnz		writeWord		;if not write the word into the sentece
	jmp		keepGoing		;otherwise, skip the word
	notSpace:
	inc		esi				;if the letter is not space then keep going
	inc		ebx				;until space
  	jmp		checkSpace

	writeWord:
	mov		edx,wordLen		;here, needs to set the esi back to the beginning of the word
	sub		edx,ecx			;it should be wordLen-ecx(it means how far the esi went when checking the word)
	sub		esi,edx			;esi-how far it went, then we got the esi at the beginning of the word
	mov		edi,[ebp+8]		;set edi to be the beginning of the sentence
	add		edi,eax			;eax stores how far the edi went
	mov		ecx,ebx			;set ecx to be the length of the word that had been checked
	cld
	rep		movsb			;copy the word to the sentence
	cmp		BYTE PTR [edi],0
	jz		finishRemoving
	mov		BYTE PTR [edi],' ';add space to the end
	inc		eax				; record how far the edi went	
	add		eax,ebx			
	mov		ebx,0			;reset ebx to 0
	inc		esi				;mov esi to next letter
	jmp		checkSpace		

	keepGoing:
	inc		esi			;keep going
	cmp		BYTE PTR [esi],0 ;check if it is the end of the sentence
	jz		finishRemoving	;if it is, then finish the program
	mov		ebx,0			;reset ebx
	jmp		checkSpace		

	finishRemoving:	
	mov		edi,[ebp+8]	;at the end, add \0 to the end of the sentence
	add		edi,eax
	dec		edi			;edi-1 because we add a space everytime when we finish writing the word into sentence
	mov		BYTE PTR [edi],0 ;so when we add edi,eax the edi will point to a space
	pop		edx				 ;so we need to go back for one position, because we want the space to be \0	
	pop		ebx
	pop		eax
	pop		ecx
	pop		edi
	pop		esi
	pop		ebp
	ret
removeWordProc	ENDP

strLenProc	PROC
	push	ebp
	mov		ebp,esp
	push	ebx
	mov		ebx,[ebp+8]
	mov		eax,0
	countbytes:
	cmp		BYTE PTR [ebx],0
	je		endcount
	inc		eax
	inc		ebx
	jmp		countbytes
	endcount:
	pop		ebx
	pop		ebp
	ret
strlenProc	ENDP
END
