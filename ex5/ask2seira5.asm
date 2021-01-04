INCLUDE MACROS.ASM
    .8086
    .MODEL SMALL
    .STACK 256 

DATA SEGMENT
    TABLE DB 256 DUP(?)
    MIN db ?
    MAX db ?
DATA ENDS

CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA
    
MAIN PROC FAR
    MOV AX,DATA
    MOV DS,AX 
    MOV AL,254                                                
    MOV DI,255
    MOV [TABLE + DI],255 ; bazoume to 255 stin teleutaia thesi
    MOV DI,254
    MOV [TABLE + DI], 0
    MOV DI,0 
   
MAKE_TABLE:
    MOV [TABLE + DI],AL   ; bale ton arithmo ston pinaka
    INC DI
    DEC AL                     
    JNZ MAKE_TABLE
    MOV DI,0
    MOV AH,0
    MOV DX,0
    
MESOS_OROS:
    MOV AL,[TABLE + DI]                
    ADD DX,AX        ; prosthetoume olous tous zugous kai tous apothikeumoume ston DX               
    ADD DI,2         ; DI+=2, afou theloume mono zugous                   
    CMP AL,255
    JNE MESOS_OROS  ; O teleutaios zugos einai o 255. Ara oso den einai 25, loop
    MOV AX,DX       ; sum ston accumulator
    MOV BH,0
    MOV BL,128                          
    DIV BL          ; AX/128 gia na bro m.o.
    MOV AH,0   
    CALL PRINT_HEX ; tipono ton m.o. se hex                
    NEW_LINE                         
    MOV DI,0                             
    MOV MIN,255    ;arxikopoioume to elaxisto sto megisto dunato kai to megisto sto elaxisto
    MOV MAX,0   
MIN_LABEL:
    MOV AL,[TABLE + DI]                 ;load number of TABLE[DI]
    CMP MIN,AL
    JB MAX_LABEL   ; sugkrine me to min, ki an einai megalutero, prosperase to
    MOV MIN,AL  ; allios AL = new min
MAX_LABEL:
    CMP MAX,AL   ; sugkrine me to max, ki an einai mikrotero, prosperase 
    JA LOOP_AGAIN
    MOV MAX,AL   ; allios max = al
LOOP_AGAIN:    
    INC DI                              ;increase index
    CMP DI,255                   ; an di = 256, telos       
    JNE MIN_LABEL                   
    MOV AH,0
    MOV AL,MIN                          
    CALL PRINT_HEX         
    PRINT ' '         
    MOV AH,0
    MOV AL,MAX
    CALL PRINT_HEX
    NEW_LINE
ENDP                 
EXIT

PRINT_HEX PROC NEAR
    PUSH BX
    MOV AH,0
    MOV AL,BL 		
    MOV BL,16 	
    MOV CX,0
HEX_ADDR1: 
    DIV BL
    INC CX			
    PUSH AX            
    CMP AL,0 		
    JE HEX_ADDR2 	
    MOV AH,0   
    JMP HEX_ADDR1		
HEX_ADDR2:
    POP DX		
    MOV DL,DH
    MOV DH,0
    CMP DL,10 
    JL  HEX_ADDR3
    ADD DX,37H
    JMP HEX_PRINT
HEX_ADDR3:  
    ADD DX,30H
HEX_PRINT:    			
    MOV AH,2
    INT 21H	
    LOOP HEX_ADDR2     
    POP BX
    PRINT '='
    RET
ENDP PRINT_HEX
