.586
.MODEL FLAT

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
number  DWORD   12
sum     DWORD   3

.CODE                           ; start of main program code
main    PROC
        mov     eax,2
        imul    3
        ret
main    ENDP

END                             ; end of source code
