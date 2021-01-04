INCLUDE MACROS.ASM
    .8086
    .MODEL SMALL
    .STACK 256    

DATA SEGMENT
DATA ENDS
  
CODE SEGMENT
    ASSUME CS:CODE, DS: DATA    
MAIN PROC FAR
	MOV AX,DATA
	MOV DS,AX 
START:
     CALL HEX_KEYB  
     CMP AL,'Q'         
     JE FINISH           	 
     MOV BL,16 
     MUL BL
     MOV BL,AL   		; o bl exei to proto psifio
     
     CALL HEX_KEYB 
     CMP AL,'Q'
     JE FINISH
     ADD BL,AL 			;o arithmos einai ston bl
      
     CALL PRINT_HEX 
     CALL PRINT_DECI
     CALL PRINT_OCT
     CALL PRINT_BIN

     JMP START
FINISH:
    EXIT     
MAIN ENDP 


HEX_KEYB PROC NEAR    
    PUSH DX
IGNORE:
    READ
    CMP AL,'Q'
    JE ADDR2 
    CMP AL,30H 
    JL IGNORE 
    CMP AL,39H
    JG ADDR1                  
    SUB AL,30H  
    JMP ADDR2              
ADDR1:  
    CMP AL,'A'
    JL IGNORE         
    CMP AL,'F'
    JG IGNORE 
    SUB AL,37H             
ADDR2:              
    POP DX 
    RET 
HEX_KEYB ENDP 

PRINT_DECI PROC NEAR
    PUSH BX
    MOV AH,0
    MOV AL,BL
    MOV BL,10 	
    MOV CX,0
DEC_ADDR: 
    DIV BL
    INC CX	
    PUSH AX       
    CMP AL,0 	 ; an den uparxoun alles 10ades, exo mono monades
    JE DEC_PRINT 	
    MOV AH,0   
    JMP DEC_ADDR
DEC_PRINT:
    POP DX	
    MOV DL,DH
    MOV DH,0		
    ADD DX,30H  ; to kanoume ascii			
    MOV AH,2
    INT 21H			
    LOOP DEC_PRINT 	; loop mexri na tupothoun ola
    POP BX 
    PRINT '='     
    RET
ENDP PRINT_DECI     

PRINT_OCT PROC NEAR
    PUSH BX
    MOV AH,0
    MOV AL,BL 
    MOV BL,8 	
    MOV CX,0 		
OCT_ADDR1: 
    DIV BL
    INC CX		
    PUSH AX                
    CMP AL,0 			 
    JE OCT_ADDR2 	
    MOV AH,0   
    JMP OCT_ADDR1			
OCT_ADDR2:
    MOV DH, AL
OCT_PRINT:
    POP DX			;pop  digit 
    MOV DL,DH
    MOV DH,0
    ADD DX,30H ; ascii value			
    MOV AH,2
    INT 21H	
    LOOP OCT_PRINT     
    POP BX
    PRINT '='
    RET
ENDP PRINT_OCT            

PRINT_BIN PROC NEAR
    PUSH BX
    MOV AH,0
    MOV AL,BL 
    MOV BL,2 	
    MOV CX,0
BIN_ADDR1: 
    DIV BL
    INC CX		
    PUSH AX               
    CMP AL,0 			
    JE BIN_ADDR2 	
    MOV AH,0   
    JMP BIN_ADDR1	
BIN_ADDR2:
    MOV DH, AL
BIN_PRINT:
    POP DX
    MOV DL,DH
    MOV DH,0			
    ADD DX,30H			
    MOV AH,2
    INT 21H
    LOOP BIN_PRINT  	     
    POP BX
    NEW_LINE
    RET
ENDP PRINT_BIN   

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

CODE ENDS