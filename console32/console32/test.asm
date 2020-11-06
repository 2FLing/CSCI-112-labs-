.586
.MODEL FLAT

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
PrimeArray   DWORD   200 DUP(?)
primeCount   DWORD   0
candidate    DWORD   2
.CODE                           ; start of main program code
main    PROC
        mov     primeCount,0
        mov     esi,0
        whileloop:
        cmp     primeCount,100
        je      endwhile
        mov     ecx,candidate
        dec     ecx
        forloop:
        mov     eax,candidate
        cmp     ecx,1
        je      endforloop
        cdq
        idiv    ecx
        cmp     edx,0
        je      nextNum
        loop    forloop
        endforloop:
        mov     eax,candidate
        mov     DWORD  PTR  PrimeArray[esi*4],eax
        inc     primeCount
        inc     esi
        nextNum:
        inc     candidate
        jmp     whileloop
        endwhile:
        mov     eax,0
        ret
main    ENDP

END                             ; end of source code
