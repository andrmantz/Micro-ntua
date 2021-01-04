INCLUDE MACROS.ASM 
    .8086
    .MODEL SMALL
    .STACK 256
  
DATA SEGMENT
DATA ENDS
  
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
      
    
    
MAIN PROC FAR  
    PRINT "X"             
    PRINT "="            
    CALL HEX_KEYB
    MOV DL,AL              
    MOV BL,BH  
    CALL HEX_KEYB         
    MOV DH,AL             
     
    PUSH DX
    PRINT BL 
    PRINT BH
    POP DX
      
    ROL DL,4      
    ADD DL,DH   
    
    PUSH DX   
     
    PRINT ' ' 
    PRINT 'Y'         
    PRINT '='
    CALL HEX_KEYB        
    MOV DL,AL                
    MOV BL,BH   
    CALL HEX_KEYB     
    MOV DH,AL       
     
    PUSH DX
    PRINT BL 
    PRINT BH
    POP DX 
      
    MOV BL,DL
    MOV BH,DH
    ROL BL,4    
    ADD BL,BH   
    
    POP DX 
    NEW_LINE  

    PUSH BX
    PUSH DX  
    PRINT 'X'
    PRINT '+' 
    PRINT 'Y' 
    PRINT '='
    POP DX 
    
    PUSH DX    ; prostheto kai tupono to apotelesma
    MOV DH,0H
    MOV BH,0H 
    ADD DX,BX
    PUSH AX
    MOV AX, DX 
    CALL PRINT_DECIMAL     
    POP AX
    POP DX 
    POP BX
         
         
    PUSH DX    
    PRINT ' '
    PRINT 'X'
    PRINT '-' 
    PRINT 'Y' 
    PRINT '='
    POP DX
    
    
    PUSH BX 
    PUSH DX
    MOV DH,0H
    MOV BH,0H  
    CMP DL,BL         ; tsekare an thetiko i arnitiko apotelesma
    JAE THETIKO
    PUSH DX
    PRINT '-' 
    POP DX
    SUB BL,DL
    MOV DL,BL 
    JMP RESULT
THETIKO:
    SUB DL,BL
RESULT:
    MOV AX,DX   
    CALL PRINT_DECIMAL
    POP DX
    POP BX
 
    RET
MAIN ENDP  


; Oles oi routines einai idies me autes tou bibliou
; opote den sumperilabame sxolia

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
    PUSH AX
    PRINT AL
    POP AX   
    SUB AL,30H
    JMP ADDR2 
ADDR1:
    CMP AL,'A'
    JL IGNORE
    CMP AL,'F'
    JG IGNORE
    PUSH AX
    PRINT AL
    POP AX
    SUB AL,37H
ADDR2:
    POP DX
    RET
HEX_KEYB ENDP


PRINT_HEX PROC NEAR
    CMP DL,9
    JLE ADDR3
    ADD DL,37H
    JMP ADDR4
ADDR3:
    ADD DL,30H
ADDR4:
    PRINT DL
    RET
PRINT_HEX ENDP
    


PRINT_DECIMAL  NEAR
    MOV BL,10 
    MOV CX,1 	
LOOP_10: 
    DIV BL
    PUSH AX           
    CMP AL,0 			
    JE PRINT_DIGITS_10 
    INC CX				
    MOV AH,0   
    JMP LOOP_10	
PRINT_DIGITS_10:
    POP DX		
    MOV DL,DH
    MOV DH,0	
    ADD DX,30H				
    MOV AH,2
    INT 21H				
    LOOP PRINT_DIGITS_10       
    RET
ENDP PRINT_DECIMAL       

CODE ENDS  
    END 