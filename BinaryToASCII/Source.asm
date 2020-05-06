TITLE --Binary to ASCII Conversion--
INCLUDE Irvine32.inc

.data
number DWORD 1234ABCDh
numberASCII BYTE 32 DUP ('X'),0

NUMBERBITWIDTH = TYPE number *8	; 4 bytes X 8 bits/byte= 32


.code
;---------------------------------------------------------------------
BinToASCII PROC	; STDCALL 
;	Input		: value of the binary number	[EBP+8],
;				  number bitwidth				[EBP+12],
;				  reference to the ASCII buffer	[EBP+16],
;	Output		: returns the ASCII equivalent of the number in 
;				  memory in the address provided by the input parameter
;   Description : The function converts a binary number to the 
;				  string
;---------------------------------------------------------------------
    ; prologue
	push ebp
	mov ebp,esp
	push eax
	push ecx
	push esi

	; function body
	mov eax, [ebp+8]	;move binary number to eax register 
	mov ecx, [ebp+12]	;initialize loop counter
	mov esi, [ebp+16]	;point esi to the address of the string 
						;number representation
L1: ; loop will scan the number from MSB to LSB
	 shl eax,1
	 jnc ZERO
	 mov BYTE PTR [esi], '1'
	 jmp ONE 
ZERO:mov BYTE PTR [esi], '0'
ONE: inc esi
	 loop L1

	; epilogue
	pop esi
	pop ecx
	pop eax
	mov esp,ebp
	pop ebp
	ret 12
BinToASCII ENDP

main PROC	
	push OFFSET numberASCII
	push NUMBERBITWIDTH
	push number
	call BinToASCII
	mov edx, OFFSET numberASCII
	call WriteString
	exit
main ENDP
END main