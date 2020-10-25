.586
.MODEL FLAT
.STACK  4096            
.DATA                  
   op   WORD    -224
.CODE                           ; start of main program code
main    PROC
   CodeBegin:
       mov rdx, R9
       mov rax, rsp
       ret
main ENDP
END                             ; end of source code
