; Example assembly language program
; This program will prompts for and inputs
; sentence and two words. Construct a new
; sentence that is identical to the old
; one except that each occurence of the first 
; word is replaced by the second word.
; Author:  MingkuanPang
; Date:    11/21/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA	; reserve storage for data
sentence		BYTE	80	DUP (?)
oldWord			BYTE	80	DUP (?)
newWord			BYTE	80  DUP (?)
tempSentence	BYTE	80  DUP	(?)
oldWordLen		DWORD	?
newWordLen		DWORD	?
sentenceLen		DWORD	?
sentencePrompt	BYTE	"Please enter a sentence:",0
wordPrompt		BYTE	"Please enter a word that you want to replace",0
newWordPrompt	BYTE	"What word you want it to be replaced with?",0
resultLbl		BYTE	"The new sentence will be: ",0

replaceWord	 MACRO	sentence,oldWord,newWord
	lea		eax,newWord
	push	eax
	lea		eax,oldWord
	push	eax
	lea		eax,sentence
	push	eax
	call	replaceWordProc
	add		esp,12
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
	input		wordPrompt,oldWord,80
	input		newWordPrompt,newWord,80
	strLen		sentence
	mov			sentenceLen,eax
	strLen		oldWord
	mov			oldWordLen,eax
	strLen		newWord
	mov			newWordLen,eax
	replaceWord	sentence,oldWord,newWord
	output		resultLbl,sentence
	mov			eax,0
	ret
_MainProc    ENDP

replaceWordProc		PROC
	push	ebp
	mov		ebp,esp
	push	edi
	push	esi
	push	ecx
	push	eax
	push	ebx
	push	edx
	mov		edi,[ebp+8]
	mov		esi,[ebp+12]
	mov		ebx,0
	mov		edx,0

	checkSpace:
	mov		ax,' '
	mov		ecx,1
	cld
	repne	scasb
	jz		checkWord

	isNotSpace:
	cmp		BYTE PTR [edi],0
	jz		checkWord
	inc		edx
	jmp		checkSpace

	checkWord:
	cmp		edx,0
	jz		finishReplacing
	mov		esi,[ebp+12]
	sub		edi,edx
	dec		edi
	mov		ecx,oldWordLen
	cld
	repe	cmpsb
	jz		rePlace

	notReplace:
	lea		edi,tempSentence
	strLen	tempSentence
	add		edi,eax
	mov		esi,[ebp+8]
	add		esi,ebx
	mov		ecx,edx
	cld	
	rep		movsb
	mov		BYTE PTR [edi],' '
	inc		ebx
	add		ebx,edx
	mov		edx,0
	mov		edi,[ebp+8]
	add		edi,ebx
	jmp		checkSpace

	rePlace:
	lea		edi,tempSentence
	strLen	tempSentence
	add		edi,eax
	mov		esi,[ebp+16]
	mov		ecx,newWordLen
	cld
	rep		movsb
	add		ebx,oldWordLen
	mov		BYTE PTR [edi],' '
	inc		ebx
	mov		edx,0
	mov		edi,[ebp+8]
	add		edi,ebx
	jmp		checkSpace

	finishReplacing:
	strLen	tempSentence
	mov		edi,[ebp+8]
	lea		esi,tempSentence
	mov		ecx,eax
	cld
	rep		movsb
	mov		BYTE PTR [edi],0
	pop		edx
	pop		ebx
	pop		eax
	pop		ecx
	pop		esi
	pop		edi
	pop		ebp
	ret
replaceWordProc		ENDP

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
