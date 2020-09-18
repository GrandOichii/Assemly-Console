format PE console

entry start

include 'win32a.inc'

section '.data' data writable

        firstPrompt db 'Enter the first number: ', 0
        secondPrompt db 'Enter the second number: ', 0
        result db '%d + %d = %d', 0

        digitInOut db '%d', 0

        first dd ?
        second dd ?

        NULL = 0

section '.code' code readable executable
        start:
                push firstPrompt
                call [printf]

                push first
                push digitInOut
                call [scanf]

                push secondPrompt
                call [printf]

                push second
                push digitInOut
                call [scanf]

                mov ebx, [first]
                add ebx, [second]

                push ebx
                push [second]
                push [first]
                push result
                call [printf]

                call [getch]
                push NULL
                call [ExitProcess]

section 'idata' import data readable
        library kernel, 'kernel32.dll', \
                msvcrt, 'msvcrt.dll'
        import kernel, \
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf', \
               scanf, 'scanf', \
               getch, '_getch'
