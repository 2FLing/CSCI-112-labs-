.586
.MODEL FLAT
.STACK  4096            
.DATA                  
   op   WORD    -224
.CODE                           ; start of main program code
main    PROC
   CodeBegin:
       mov      rbx,-1
       mov      r14,1
       add      rbx,r14
       ret
main ENDP
END                             ; end of source code
