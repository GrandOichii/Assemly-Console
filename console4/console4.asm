format PE console

entry start

include 'win32a.inc'

section '.data' data writable

        namePrompt db 'What is your name? ', 0
        timesPrompt db 'How many times do you wish for me to repeat your name? ', 0
        newLine db '', 10, 0

        stringInOut db '%s', 0
        digitIn db '%d', 0

        name dt ?
        num dd ?

        NULL = 0

section '.code' code readable executable
        start:
                push namePrompt
                call [printf]

                push name
                push stringInOut
                call [scanf]

                push timesPrompt
                call [printf]

                push num
                push digitIn
                call [scanf]

                mov ebx, 1
                lp:
                        push name
                        push stringInOut
                        call [printf]

                        push newLine
                        call [printf]

                        add ebx, 1
                        cmp ebx, [num]
                        jle lp
                        jmp finish

                finish:
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
