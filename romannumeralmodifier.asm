INCLUDE Irvine32.inc

.data
titleMsg      BYTE "Low Level Programming Language | Assembly", 0Dh, 0Ah, 0
welcomeMsg    BYTE "Welcome to Roman Numeral Modifier", 0Dh, 0Ah, 0
namePrompt    BYTE "What is your name? ", 0
helloMsg      BYTE "Hello, ", 0
menuMsg       BYTE "Choose an option:", 0Dh, 0Ah, "1 - Integer to Roman Numeral", 0Dh, 0Ah, "2 - Roman Numeral to Integer", 0Dh, 0Ah, 0
promptChoice  BYTE "Enter your choice (1/2): ", 0
invalidMsg    BYTE "Invalid input!", 0Dh, 0Ah, 0
intPrompt     BYTE "Enter an integer (1-20): ", 0
romanPrompt   BYTE "Enter a Roman Numeral (I-XX): ", 0
resultMsg     BYTE "Result: ", 0Dh, 0Ah, 0
execTimeMsg   BYTE "Execution time: ", 0
timeUnit      BYTE " ms", 0
convertMsg    BYTE "Do you want to convert again (Y/N)? ", 0
goodbyeMsg    BYTE "Thank you for using the Roman Numeral Modifier. Have a great day ahead!", 0

stepMsg1      BYTE "Step 1: Validating input... Done.", 0Dh, 0Ah, 0
stepMsg2Int   BYTE "Step 2: Retrieving corresponding Roman numeral... Done.", 0Dh, 0Ah, 0
stepMsg2Roman BYTE "Step 2: Matching input to known Roman numerals... Done.", 0Dh, 0Ah, 0
stepMsg3      BYTE "Step 3: Displaying the result... Done.", 0Dh, 0Ah, 0

inputBuffer   BYTE 16 DUP(0)     ; Buffer for user input (max 16 characters)

.data
romanValues   DWORD OFFSET roman1, OFFSET roman2, OFFSET roman3, OFFSET roman4, OFFSET roman5
              DWORD OFFSET roman6, OFFSET roman7, OFFSET roman8, OFFSET roman9, OFFSET roman10
              DWORD OFFSET roman11, OFFSET roman12, OFFSET roman13, OFFSET roman14, OFFSET roman15
              DWORD OFFSET roman16, OFFSET roman17, OFFSET roman18, OFFSET roman19, OFFSET roman20
numValues     DWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
              DWORD 11, 12, 13, 14, 15, 16, 17, 18, 19, 20

roman1        BYTE "I", 0
roman2        BYTE "II", 0
roman3        BYTE "III", 0
roman4        BYTE "IV", 0
roman5        BYTE "V", 0
roman6        BYTE "VI", 0
roman7        BYTE "VII", 0
roman8        BYTE "VIII", 0
roman9        BYTE "IX", 0
roman10       BYTE "X", 0
roman11       BYTE "XI", 0
roman12       BYTE "XII", 0
roman13       BYTE "XIII", 0
roman14       BYTE "XIV", 0
roman15       BYTE "XV", 0
roman16       BYTE "XVI", 0
roman17       BYTE "XVII", 0
roman18       BYTE "XVIII", 0
roman19       BYTE "XIX", 0
roman20       BYTE "XX", 0

buffer        BYTE 20 DUP(0) ; Buffer for input storage

.code
main PROC
    ; Display title
    mov edx, OFFSET titleMsg
    call WriteString
    call Crlf

    ; Display welcome message
    mov edx, OFFSET welcomeMsg
    call WriteString
    call Crlf

    ; Prompt for the user's name
    mov edx, OFFSET namePrompt
    call WriteString
    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer
    call ReadString             ; Store name in buffer
    mov edx, OFFSET helloMsg    ; Display "Hello, "
    call WriteString
    mov edx, OFFSET buffer      ; Display user's name
    call WriteString
    call Crlf

MenuLoop:
    ; Display menu options
    mov edx, OFFSET menuMsg
    call WriteString

    ; Prompt for choice
    mov edx, OFFSET promptChoice
    call WriteString
    call ReadChar
    sub al, '0'                 ; Convert ASCII to number
    mov bl, al                  ; Store choice in BL

    ; Validate choice
    cmp bl, 1
    je IntegerToRoman
    cmp bl, 2
    je RomanToInteger
    jmp InvalidInput            ; Invalid choice

IntegerToRoman:
    mov eax, 0                  ; Clear EAX for start time
    call GetMSeconds            ; Get the start time
    mov ebx, eax                ; Store the start time in EBX

    ; Step 1: Prompt and validate input
    mov edx, OFFSET stepMsg1
    call WriteString
    mov edx, OFFSET intPrompt
    call WriteString
    call ReadInt                ; Get integer input
    cmp eax, 1
    jl InvalidInput             ; Reject numbers < 1
    cmp eax, 20
    jg InvalidInput             ; Reject numbers > 20

    ; Step 2: Conversion
    mov edx, OFFSET stepMsg2Int
    call WriteString
    lea esi, romanValues        ; Load address of Roman numeral pointers
    dec eax                     ; Zero-based index (e.g., 1 = I is at index 0)
    mov esi, [esi + eax*4]      ; Get pointer to the Roman numeral
    mov edx, OFFSET resultMsg
    call WriteString            ; Print "Result: "
    mov edx, esi
    call WriteString            ; Display Roman numeral
    call Crlf

    ; Step 3: Display result
    mov edx, OFFSET stepMsg3
    call WriteString

    ; Calculate and display execution time
    call GetMSeconds            ; Get the end time
    sub eax, ebx                ; Subtract start time from end time
    mov edx, OFFSET execTimeMsg
    call WriteString            ; Display "Execution time: "
    call WriteDec               ; Display the execution time
    mov edx, OFFSET timeUnit
    call WriteString            ; Display " ms"
    call Crlf
    jmp ConvertPrompt

RomanToInteger:
    mov eax, 0                  ; Clear EAX for start time
    call GetMSeconds            ; Get the start time
    mov ebx, eax                ; Store the start time in EBX

    ; Step 1: Prompt and validate input
    mov edx, OFFSET stepMsg1
    call WriteString
    mov edx, OFFSET romanPrompt
    call WriteString
    mov edx, OFFSET inputBuffer
    mov ecx, SIZEOF inputBuffer
    call ReadString             ; Read Roman numeral input
    lea esi, inputBuffer
    call TrimInput
    lea esi, inputBuffer
    call ToUpperCase

    ; Step 2: Match input
    mov edx, OFFSET stepMsg2Roman
    call WriteString
    lea edi, romanValues
    mov ecx, 20                 ; Number of Roman numerals (now 20)
    xor eax, eax                ; Default: no match found

FindMatch:
    mov edx, [edi]              ; Load address of current Roman numeral
    call StrCompare             ; Compare input with current Roman numeral
    jz MatchFound               ; If strings match, jump to MatchFound
    add edi, 4                  ; Move to next Roman numeral
    loop FindMatch

    ; If no match is found, display error and return to menu
    mov edx, OFFSET invalidMsg
    call WriteString
    call Crlf
    jmp MenuLoop

MatchFound:
    lea esi, numValues          ; Load address of numValues array
    sub ecx, 10                 ; Adjust ECX for reverse indexing
    neg ecx                     ; Convert ECX to positive index
    shl ecx, 2                  ; Multiply index by 4 (DWORD size)
    mov eax, [esi + ecx]        ; Get corresponding integer value

    ; Step 3: Display result
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteDec
    call Crlf
    mov edx, OFFSET stepMsg3
    call WriteString
    jmp ConvertPrompt

ConvertPrompt:
    mov edx, OFFSET convertMsg
    call WriteString
    call ReadChar
    cmp al, 'Y'
    je MenuLoop
    cmp al, 'N'
    je ExitProgram
    jmp ConvertPrompt

InvalidInput:
    mov edx, OFFSET invalidMsg
    call WriteString
    call Crlf
    jmp MenuLoop

ToUpperCase PROC
    push esi
    push eax
    ToUpperLoop:
        lodsb                   ; Load a character from the buffer
        test al, al             ; Check for null terminator
        je ToUpperEnd           ; Exit if end of string
        cmp al, 'a'             ; Check if lowercase
        jl NotLowercase         ; Skip if not lowercase
        cmp al, 'z'
        jg NotLowercase
        sub al, 32              ; Convert to uppercase
    NotLowercase:
        stosb                   ; Store back in the buffer
        jmp ToUpperLoop
    ToUpperEnd:
        pop eax
        pop esi
        ret
ToUpperCase ENDP

TrimInput PROC
    push esi
    push edi
    mov edi, esi                ; Set EDI to write trimmed data
TrimLoop:
    lodsb                       ; Load byte from source
    test al, al                 ; Check for null terminator
    je TrimEnd                  ; If end of string, exit
    cmp al, ' '                 ; Check if space
    je TrimLoop                 ; Skip spaces
    stosb                       ; Store non-space character
    jmp TrimLoop
TrimEnd:
    mov byte ptr [edi], 0       ; Null-terminate trimmed string
    pop edi
    pop esi
    ret
TrimInput ENDP

StrCompare PROC
    ; Compare strings for equality
    push esi
    push edi
    xor eax, eax                ; Clear EAX
CompareLoop:
    mov al, [esi]
    mov bl, [edi]
    cmp al, bl
    jne NotEqual
    cmp al, 0                   ; End of string
    je StringsEqual
    inc esi
    inc edi
    jmp CompareLoop

NotEqual:
    mov eax, 1                  ; Not equal
    jmp CompareEnd

StringsEqual:
    xor eax, eax                ; Equal

CompareEnd:
    pop edi
    pop esi
    ret
StrCompare ENDP

ExitProgram:
    mov edx, OFFSET goodbyeMsg
    call WriteString
    call Crlf
    exit
main ENDP

END main