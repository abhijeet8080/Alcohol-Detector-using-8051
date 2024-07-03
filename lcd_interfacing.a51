//Group No A11
//Problem Statement: Design a Alcohol Detector using 8051

		
		
         ;LCD IS CONNECTED TO P2 PORT OF 8051
         ;GAS SENSOR IS CONNECTED TO P1.0 PIN OF 8051
         ;BUZZER/LED IS CONNECTED TO P3.2 PIN
         ;RS PIN OF LCD TO P3.5
         ;R/W PIN OF LCD TO P3.6
         ;E PIN OF LCD TO P3.7
            
			LCD EQU P2
			MQ3 EQU P1.0
			LED EQU P3.2
			RS EQU P3.5
			RW EQU P3.6
			E EQU P3.7
			

            ORG 0000H
            MOV P1, #0FFh        	; Initialize P1 port for input
            MOV P2, #00h         	; Initialize P2 port for output


         
LOOP:      JB MQ3, NOT_DETECTED 	;JUMP IF P1.0 IS 1   /Alcohol Not Detected
           ACALL DETECTED        	;CALL 'DETECTED'    / Alcohol Detected
           SJMP LOOP             	;Keep doing this infinitely   

DETECTED:
           SETB LED             	;SET P3.2/LED 
           ACALL LCD_PRE         	;CALL LCD PRE
	       ACALL MSG_ALCOHOL        ;PRINT 'ALCOHOL' ON LCD
	       MOV A,#' '            
           ACALL DISPLAY            ;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
	       ACALL MSG_DETECTED    	;PRINT 'DETECTED' ON LCD
	       ACALL LONG_DELAY      	;CALL DELAY
		   ACALL LONG_DELAY
 		   ACALL LONG_DELAY


	       RET                   	;RETRUN 
NOT_DETECTED:                    
           CLR LED             		;TURN OFF THE LED/CLEAR THE P3.2 PORT
           ACALL LCD_PRE         	;CALL LCD PRE
           ACALL MSG_ALCOHOL     	;PRINT 'ALCOHOL' ON LCD
	       MOV A,#' '          
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
	       MOV A,#'N'            	;DISPLAY LETTER N
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
		   MOV A,#'O'            	;DISPLAY LETTER O
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'T'            	;DISPLAY LETTER T
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
		   MOV A,#06H            	;SHIFT CURSOR TO RIGHT
           ACALL COMMAND         	;CALL COMMAND SUBROUTINE
		   MOV A,#0C0H           	;FORCE CURSOR TO BEGINNING OF 2ND LINE
           ACALL COMMAND         	;CALL COMMAND SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           ACALL MSG_DETECTED		;PRINT DETECTED ON LCD
		   ACALL DELAY
		   SJMP LOOP             	;JUMP TO LOOP
		   RET                   	;RETURN
 LCD_PRE: 
           MOV A,#38H            	;INITIALIZE LCD 2 LINES AND 5X7 MATRIX
           ACALL COMMAND         	;CALL COMMADN SUBROUTINE
           MOV A,#0EH            	;DISPLAY ON , CURSOR BLINKING
           ACALL COMMAND         	;CALL COMMADN SUBROUTINE
           MOV A,#01H            	;CLEAR LCD
           ACALL COMMAND         	;CALL COMMAND SUBROUTINE
           MOV A,#06H            	;SHIFT CURSOR TO RIGHT
           ACALL COMMAND         	;CALL COMMAND SUBROUTINE
           MOV A,#80H            	;FORCE CURSOR TO BEGINNING OF 1ST LINE
           ACALL COMMAND         	;CALL COMMAND SUBROUTINE 
           ACALL DELAY           	;GIVE LCD SOMETIME
		   RET                   	;RETURN
MSG_ALCOHOL: 
           MOV A,#'A'            	;DISPLAY LETTER A
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'L'            	;DISPLAY LETTER L
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'C'            	;DISPLAY LETTER C
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'O'            	;DISPLAY LETTER O
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'H'            	;DISPLAY LETTER H
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'O'            	;DISPLAY LETTER O
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'L'            	;DISPLAY LETTER L
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
		   RET                   	;RETURN
MSG_DETECTED:		
        
           MOV A,#'D'            	;DISPLAY LETTER D
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
		   MOV A,#'E'            	;DISPLAY LETTER E
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'T'            	;DISPLAY LETTER T
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'E'            	;DISPLAY LETTER E
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'C'            	;DISPLAY LETTER C
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
           MOV A,#'T'            	;DISPLAY LETTER T
           ACALL DISPLAY         	;GIVE LCD SOMETIME
           MOV A,#'E'            	;DISPLAY LETTER E
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
		   MOV A,#'D'            	;DISPLAY LETTER D
           ACALL DISPLAY         	;CALL DISPLAY SUBROUTINE
           ACALL DELAY           	;GIVE LCD SOMETIME
		   RET                   	;RETURN

COMMAND:   
           MOV LCD,A              	;COPY REGISTER A TO PORT 2
           CLR RS              		;RS = 0 FOR COMMAND
           CLR RW             	    ;R/W =0 FOR WRITE
           SETB E             		;E = 1 FOR HIGH PULSE
           ACALL DELAY           	;GIVE LCD SOMETIME
           CLR E              		;E = 0 FOR H-TO-L PULSE
           RET                   	;RETURN TO MAIN PROGRAM
 
 
 DISPLAY:  
           MOV LCD,A              	;COPY REGISTER A TO PORT 2
           SETB RS             		;RS = 1 FOR COMMAND
           CLR RW             		;R/W =0 FOR WRITE
           SETB E             		;E = 1 FOR HIGH PULSE
           ACALL DELAY           	;GIVE LCD SOMETIME
           CLR E              		;E = 0 FOR H-TO-L PULSE
           RET                   	;RETURN TO MAIN PROGRMA

 DELAY:    
           MOV R3, #100            
 HERE2:    MOV R4, #255           
 HERE1:    DJNZ R4, HERE1         
           DJNZ R3, HERE2
           RET
		
Long_DELAY:
           MOV R5,#10
AGAIN1:	   MOV R6,#0FFH
NEXT:      MOV R7,#0FFH
AGAIN:     DJNZ R7, AGAIN
           DJNZ R6, NEXT
		   DJNZ R5,AGAIN1
		   RET
           END