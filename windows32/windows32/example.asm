; Example assembly language program -- adds 158 to number in memory
; Author:  MingkuanPang
; Date:    10/8/2020    

.586
.MODEL FLAT
 INCLUDE io.h
.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
x     DWORD ?
y     DWORD ?
z    DWORD ?
first_half  DWORD ?
last_half   DWORD ?
prompt1 BYTE    "Please enter the first number",0
prompt2 BYTE    "Please enter the second number",0
prompt3 BYTE    "Please enter the third number",0
string     BYTE    30 DUP (?)
answer  BYTE    "The result is:",0
result    BYTE    11 DUP (?),   0 

.CODE       ;(( x + y ) * z + 17) % ( (x + 1 ) * (y 每 1) / z^2)
_MainProc    PROC
        input   prompt1, string, 30
        atod    string
        mov     x,eax

        input   prompt2, string, 30
        atod     string
        mov     y,eax

        input   prompt3, string, 30
        atod     string
        mov     z,eax

        mov     eax,x
        add     eax,y   ;x+y
        imul    z       ;(x+y)*z    
        add     eax,11H     ;(x+y)*z+17
        mov     first_half,eax  ;put (x+y)*z+17 into first_half
        inc     x   ;x+1
        dec     y   ;y-1    
        mov     eax,x   
        imul    y   ;(x + 1 ) * (y 每 1)
        mov     ebx,z
        imul    ebx,ebx     ;z*z
        idiv    ebx     ; (x + 1 ) * (y 每 1) / z^2)
        mov     last_half,eax   ; put (x + 1 ) * (y 每 1) / z^2) into last_half
        mov     eax,first_half
        cdq   ;there is a weird thing, the value in my edx been added the remainder instead of replacing.
                        ;like edx=00 00 00 01 before next idiv instruction, and the remainder is 2
                        ;then after I executed next idiv instruction, my edx will be 00 00 00 03 instead of 00 00 00 02
                        ;so I have to reset the edx value to 0.
        idiv    last_half
        dtoa    result,edx
        output  answer,result
        
        mov     eax,0
        ret
_MainProc    ENDP
END                             ; end of source code
