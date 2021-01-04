INCLUDE MACROS.ASM
    .8086
    .MODEL SMALL
    .STACK 256
    
DATA SEGMENT
    TABLE DB 16 DUP(?)
DATA ENDS

CODE SEGMENT
    ASSUME CS : CODE, DS : DATA
    
MAIN PROC FAR
    MOV AX,DATA
    MOV DS,AX
   
START:
    MOV DI,0
    MOV CL,0
    
READ:
    READ_IN
    CMP AL,13
    JE QUIT         ; enter = telos
    CMP AL,'0'
    JL READ         ; dexomaste mono arithmous metaksu 0-9
    CMP AL,'9'
    JNA OK
    CMP AL,'A'
    JL READ          ; dexomaste mono kefalaia grammata 
    CMP AL,'Z'
    JG READ
    
OK:
    MOV [TABLE + DI],AL
    INC DI
    INC CL                                                                        
    CMP CL,17  ; 16 chars + enter char 
    JNZ READ                            

    MOV DI,0
    MOV CL,0

PRINT1: ; tupose oles tis theseis tou pinaka
    MOV AL,[TABLE + DI]  
    PRINT AL                         
    INC DI                                  
    INC CL
    CMP CL,15 ; an cl!=15, exo akoma chars na tuposo
    JNZ PRINT1

    NEW_LINE

    MOV DI,0
    MOV CL,0        


PRINT2:                                
    MOV AL,[TABLE + DI]                     
    CMP AL,3AH ; an mikrotero you 3A hex, tote einai arithmos kai ton tuponoume                             
    JA CONTINUE     ; an einai megalutero, einai gramma kai to prospername
    PRINT AL

CONTINUE:
    INC DI
    INC CL
    CMP CL,15
    JB PRINT2 
    ; telos arithmoi, ara tuponoume - kai pame sta grammata
    PRINT '-'
    MOV DI,0
    MOV CL,0                                

    
PRINT_LETTERS:  
    MOV AL,[TABLE + DI]
    CMP AL,40H
    JBE NEXT_LETTER

    ADD AL,32 ; an > 40H, einai kefalaio gramma kai prosthetoume 23 dec gia na ginei mikro
    PRINT AL

NEXT_LETTER:
    INC DI
    INC CH
    CMP CH,16
    JB PRINT_LETTERS
    NEW_LINE ; telos, tuponoume new line
    JMP START    ; kai jmp start gia sunexi leitourgia
    
QUIT:
    EXIT
    MAIN END