.586
.MODEL FLAT

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
primeArray   DWORD   200 DUP(?)
primeCount   DWORD   0
candidate    DWORD   2
.CODE                           ; start of main program code
main    PROC
        mov     primeCount,0  ;initialize the number of the prime number to 0
        mov     esi,0         ;initialize the index of the array to 0
        whileloop:
        cmp     primeCount,100  ; when the count of the prime number is less then 100, keep finding next prime number
        je      endwhile        ; otherwise quit finding prime number
        mov     ecx,candidate   
        dec     ecx             
        forloop:                ;search if there is a divisor in the range between 2 and candidate number-1
                                ;for(int i=2; i<candidate;i++)
        mov     eax,candidate
        cmp     ecx,1           
        je      endforloop      ; if ecx equals 1 then it means the candidate number is a prime number
        cdq
        idiv    ecx
        cmp     edx,0           
        je      nextNum         ;if candidate can be divided by the number in the range, then it is not a prime number
                                ;thus, move to next candidate
        loop    forloop
        endforloop:
        mov     eax,candidate
        mov     DWORD  PTR  primeArray[esi*4],eax   
        inc     primeCount       ;if the candidate number is prime number then primecount+1 and move the index of the array to next
        inc     esi
        nextNum:                 ; otherwise check next candidate without primecount+1 and set index to next
        inc     candidate
        jmp     whileloop
        endwhile:
        mov     eax,0
        ret
main    ENDP

END                             ; end of source code
