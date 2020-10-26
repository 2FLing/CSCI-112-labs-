; Listing generated by Microsoft (R) Optimizing Compiler Version 19.27.29111.0 

include listing.inc

INCLUDELIB MSVCRTD
INCLUDELIB OLDNAMES

_DATA	SEGMENT
COMM	_hInstance:QWORD
_DATA	ENDS
PUBLIC	WinMain
PUBLIC	DlgProc
PUBLIC	getInput
PUBLIC	showOutput
EXTRN	__report_rangecheckfailure:PROC
EXTRN	strcpy:PROC
EXTRN	__imp_DialogBoxParamA:PROC
EXTRN	__imp_EndDialog:PROC
EXTRN	__imp_GetDlgItem:PROC
EXTRN	__imp_SetDlgItemTextA:PROC
EXTRN	__imp_GetDlgItemTextA:PROC
EXTRN	__imp_GetWindowTextLengthA:PROC
EXTRN	__imp_MessageBoxA:PROC
EXTRN	MainProc:PROC
EXTRN	_RTC_InitBase:PROC
EXTRN	_RTC_Shutdown:PROC
_BSS	SEGMENT
buf	DB	0ffH DUP (?)
	ALIGN	4

inputLabel DB	0ffH DUP (?)
	ALIGN	4

$SG95130 DB	01H DUP (?)
_BSS	ENDS
pdata	SEGMENT
$pdata$WinMain DD imagerel $LN3
	DD	imagerel $LN3+68
	DD	imagerel $unwind$WinMain
$pdata$DlgProc DD imagerel $LN14
	DD	imagerel $LN14+312
	DD	imagerel $unwind$DlgProc
$pdata$getInput DD imagerel $LN5
	DD	imagerel $LN5+164
	DD	imagerel $unwind$getInput
$pdata$showOutput DD imagerel $LN3
	DD	imagerel $LN3+62
	DD	imagerel $unwind$showOutput
pdata	ENDS
;	COMDAT rtc$TMZ
rtc$TMZ	SEGMENT
_RTC_Shutdown.rtc$TMZ DQ FLAT:_RTC_Shutdown
rtc$TMZ	ENDS
;	COMDAT rtc$IMZ
rtc$IMZ	SEGMENT
_RTC_InitBase.rtc$IMZ DQ FLAT:_RTC_InitBase
rtc$IMZ	ENDS
_DATA	SEGMENT
$SG95135 DB	'Warning', 00H
$SG95136 DB	'Nothing entered', 00H
_DATA	ENDS
xdata	SEGMENT
$unwind$WinMain DD 022d01H
	DD	070153219H
$unwind$DlgProc DD 022c01H
	DD	070145218H
$unwind$getInput DD 022801H
	DD	070107214H
$unwind$showOutput DD 022301H
	DD	0700b320fH
xdata	ENDS
; Function compile flags: /Odtp /RTCsu
; File C:\Users\Administrator\Desktop\lab(csci-112)\windows64\windows64\framework.c
_TEXT	SEGMENT
outputLabel$ = 48
outputString$ = 56
showOutput PROC

; 71   : {

$LN3:
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+8], rcx
	push	rdi
	sub	rsp, 32					; 00000020H
	mov	rdi, rsp
	mov	ecx, 8
	mov	eax, -858993460				; ccccccccH
	rep stosd
	mov	rcx, QWORD PTR [rsp+48]

; 72   : 	MessageBox(NULL, outputString, outputLabel, MB_OK);

	xor	r9d, r9d
	mov	r8, QWORD PTR outputLabel$[rsp]
	mov	rdx, QWORD PTR outputString$[rsp]
	xor	ecx, ecx
	call	QWORD PTR __imp_MessageBoxA

; 73   : }

	add	rsp, 32					; 00000020H
	pop	rdi
	ret	0
showOutput ENDP
_TEXT	ENDS
; Function compile flags: /Odtp /RTCsu
; File C:\Users\Administrator\Desktop\lab(csci-112)\windows64\windows64\framework.c
_TEXT	SEGMENT
$T1 = 48
inputPrompt$ = 80
result$ = 88
maxChars$ = 96
getInput PROC

; 60   : {

$LN5:
	mov	DWORD PTR [rsp+24], r8d
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+8], rcx
	push	rdi
	sub	rsp, 64					; 00000040H
	mov	rdi, rsp
	mov	ecx, 16
	mov	eax, -858993460				; ccccccccH
	rep stosd
	mov	rcx, QWORD PTR [rsp+80]

; 61   : 	strcpy(inputLabel, inputPrompt);

	mov	rdx, QWORD PTR inputPrompt$[rsp]
	lea	rcx, OFFSET FLAT:inputLabel
	call	strcpy

; 62   : 	DialogBox(_hInstance, MAKEINTRESOURCE(IDD_MAIN), NULL, DlgProc);

	mov	QWORD PTR [rsp+32], 0
	lea	r9, OFFSET FLAT:DlgProc
	xor	r8d, r8d
	mov	edx, 101				; 00000065H
	mov	rcx, QWORD PTR _hInstance
	call	QWORD PTR __imp_DialogBoxParamA

; 63   : 	buf[maxChars-1] = '\0'; // in case too many characters, terminate string at maxChars

	mov	eax, DWORD PTR maxChars$[rsp]
	dec	eax
	cdqe
	mov	QWORD PTR $T1[rsp], rax
	cmp	QWORD PTR $T1[rsp], 255			; 000000ffH
	jae	SHORT $LN3@getInput
	jmp	SHORT $LN4@getInput
$LN3@getInput:
	call	__report_rangecheckfailure
$LN4@getInput:
	lea	rax, OFFSET FLAT:buf
	mov	rcx, QWORD PTR $T1[rsp]
	mov	BYTE PTR [rax+rcx], 0

; 64   : 	strcpy(result, buf);

	lea	rdx, OFFSET FLAT:buf
	mov	rcx, QWORD PTR result$[rsp]
	call	strcpy
$LN2@getInput:

; 65   : 	return;
; 66   : }

	add	rsp, 64					; 00000040H
	pop	rdi
	ret	0
getInput ENDP
_TEXT	ENDS
; Function compile flags: /Odtp /RTCsu
; File C:\Users\Administrator\Desktop\lab(csci-112)\windows64\windows64\framework.c
_TEXT	SEGMENT
len$1 = 32
tv64 = 36
tv74 = 40
hwnd$ = 64
Message$ = 72
wParam$ = 80
lParam$ = 88
DlgProc	PROC

; 10   : {

$LN14:
	mov	QWORD PTR [rsp+32], r9
	mov	QWORD PTR [rsp+24], r8
	mov	DWORD PTR [rsp+16], edx
	mov	QWORD PTR [rsp+8], rcx
	push	rdi
	sub	rsp, 48					; 00000030H
	mov	rdi, rsp
	mov	ecx, 12
	mov	eax, -858993460				; ccccccccH
	rep stosd
	mov	rcx, QWORD PTR [rsp+64]

; 11   : 	switch(Message)

	mov	eax, DWORD PTR Message$[rsp]
	mov	DWORD PTR tv64[rsp], eax
	cmp	DWORD PTR tv64[rsp], 16
	je	$LN11@DlgProc
	cmp	DWORD PTR tv64[rsp], 272		; 00000110H
	je	SHORT $LN6@DlgProc
	cmp	DWORD PTR tv64[rsp], 273		; 00000111H
	je	SHORT $LN7@DlgProc
	jmp	$LN12@DlgProc
$LN6@DlgProc:

; 12   : 	{
; 13   : 		case WM_INITDIALOG:
; 14   : 			// This is where we set up the dialog box, and initialise any default values
; 15   : 			SetDlgItemText(hwnd, IDC_LABEL, inputLabel);

	lea	r8, OFFSET FLAT:inputLabel
	mov	edx, 1009				; 000003f1H
	mov	rcx, QWORD PTR hwnd$[rsp]
	call	QWORD PTR __imp_SetDlgItemTextA

; 16   : 			SetDlgItemText(hwnd, IDC_TEXT, "");

	lea	r8, OFFSET FLAT:$SG95130
	mov	edx, 1000				; 000003e8H
	mov	rcx, QWORD PTR hwnd$[rsp]
	call	QWORD PTR __imp_SetDlgItemTextA

; 17   : 		break;

	jmp	$LN2@DlgProc
$LN7@DlgProc:

; 18   : 
; 19   : 		case WM_COMMAND:
; 20   : 			switch(LOWORD(wParam))

	mov	rax, QWORD PTR wParam$[rsp]
	and	rax, 65535				; 0000ffffH
	movzx	eax, ax
	mov	DWORD PTR tv74[rsp], eax
	cmp	DWORD PTR tv74[rsp], 1007		; 000003efH
	je	SHORT $LN8@DlgProc
	jmp	SHORT $LN4@DlgProc
$LN8@DlgProc:

; 21   : 			{
; 22   : 				case IDC_OK:
; 23   : 				{
; 24   : 					// When somebody clicks the Add button, first we get the number of
; 25   : 					// they entered
; 26   : 
; 27   : 					int len = GetWindowTextLength(GetDlgItem(hwnd, IDC_TEXT));

	mov	edx, 1000				; 000003e8H
	mov	rcx, QWORD PTR hwnd$[rsp]
	call	QWORD PTR __imp_GetDlgItem
	mov	rcx, rax
	call	QWORD PTR __imp_GetWindowTextLengthA
	mov	DWORD PTR len$1[rsp], eax

; 28   : 					if(len > 0)

	cmp	DWORD PTR len$1[rsp], 0
	jle	SHORT $LN9@DlgProc

; 29   : 					{
; 30   : 						// get the string into our buffer and exit
; 31   : 						GetDlgItemText(hwnd, IDC_TEXT, buf, len + 1);

	mov	eax, DWORD PTR len$1[rsp]
	inc	eax
	mov	r9d, eax
	lea	r8, OFFSET FLAT:buf
	mov	edx, 1000				; 000003e8H
	mov	rcx, QWORD PTR hwnd$[rsp]
	call	QWORD PTR __imp_GetDlgItemTextA

; 32   : 						EndDialog(hwnd, 0);

	xor	edx, edx
	mov	rcx, QWORD PTR hwnd$[rsp]
	call	QWORD PTR __imp_EndDialog

; 33   : 					}

	jmp	SHORT $LN10@DlgProc
$LN9@DlgProc:

; 34   : 					else 
; 35   : 					{
; 36   : 						MessageBox(hwnd, "Nothing entered", "Warning", MB_OK);

	xor	r9d, r9d
	lea	r8, OFFSET FLAT:$SG95135
	lea	rdx, OFFSET FLAT:$SG95136
	mov	rcx, QWORD PTR hwnd$[rsp]
	call	QWORD PTR __imp_MessageBoxA
$LN10@DlgProc:
$LN4@DlgProc:

; 37   : 					}
; 38   : 				}
; 39   : 				break;
; 40   : 			}
; 41   : 		break;

	jmp	SHORT $LN2@DlgProc
$LN11@DlgProc:

; 42   : 
; 43   : 		case WM_CLOSE:
; 44   : 			EndDialog(hwnd, 0);

	xor	edx, edx
	mov	rcx, QWORD PTR hwnd$[rsp]
	call	QWORD PTR __imp_EndDialog

; 45   : 		break;

	jmp	SHORT $LN2@DlgProc
$LN12@DlgProc:

; 46   : 
; 47   : 		default:
; 48   : 			return FALSE;

	xor	eax, eax
	jmp	SHORT $LN1@DlgProc
$LN2@DlgProc:

; 49   : 	}
; 50   : 	return TRUE;

	mov	eax, 1
$LN1@DlgProc:

; 51   : }

	add	rsp, 48					; 00000030H
	pop	rdi
	ret	0
DlgProc	ENDP
_TEXT	ENDS
; Function compile flags: /Odtp /RTCsu
; File C:\Users\Administrator\Desktop\lab(csci-112)\windows64\windows64\framework.c
_TEXT	SEGMENT
hInstance$ = 48
hPrevInstance$ = 56
lpCmdLine$ = 64
nCmdShow$ = 72
WinMain	PROC

; 80   : {

$LN3:
	mov	DWORD PTR [rsp+32], r9d
	mov	QWORD PTR [rsp+24], r8
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+8], rcx
	push	rdi
	sub	rsp, 32					; 00000020H
	mov	rdi, rsp
	mov	ecx, 8
	mov	eax, -858993460				; ccccccccH
	rep stosd
	mov	rcx, QWORD PTR [rsp+48]

; 81   : 	_hInstance = hInstance;

	mov	rax, QWORD PTR hInstance$[rsp]
	mov	QWORD PTR _hInstance, rax

; 82   : 	return MainProc();

	call	MainProc

; 83   : }

	add	rsp, 32					; 00000020H
	pop	rdi
	ret	0
WinMain	ENDP
_TEXT	ENDS
END
