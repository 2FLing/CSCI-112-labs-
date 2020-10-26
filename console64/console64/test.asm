.DATA                   ; reserve storage for data
number  QWORD   -105
sum     QWORD   ?

.CODE                           ; start of main program code
main    PROC
        mov     rax, number     ; first number to EAX
        add     rax, 158        ; add 158
        mov     sum, rax        ; sum to memory
        mov     rax, 0            ; exit with return code 0
        ret
main    ENDP

END                             ; end of source code
