format PE console

entry start

include 'win32a.inc'

section '.data' data writable

        namePrompt db 'What is your name? ', 0
        agePrompt db 'How old are you? ', 0
        result db 'Your name is %s, and you are %d years old', 0

        stringInOut db '%s', 0
        digitInOut db '%d', 0

        name dt ?
        age dd ?

        NULL = 0

section '.code' code readable executable
        start:
                push namePrompt
                call [printf]

                push name
                push stringInOut
                call [scanf]

                push agePrompt
                call [printf]

                push age
                push digitInOut
                call [scanf]

                push [age]
                push name
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
