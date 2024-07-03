ORG 0000h
MOV P1, #0FFh    ; Initialize P1 port for input
MOV P2, #00h     ; Initialize P2 port for output


LOOP:
  MOV A,#01H        //clear lcd
  ACALL COMMAND     //call command subroutine
  JB P1.0, a   ; Compare R0 with the threshold value and branch if it is below the threshold
  ACALL DISPLAY_MSG   ; If the alcohol concentration is above the threshold, display the message on the LCD
  SJMP LOOP   ; Repeat the process

READ_SENSOR:
  MOV A, P1   ; Read the LSB of P1 port where MQ3 sensor is connected
  MOV R0, A     ; Store the sensor value in R0
  RET
  
  NO_ALCOHOL:
  SJMP LOOP

DISPLAY_MSG:
  MOV A,#38H        //init. LCD 2 lines and 5x7 matrix
        ACALL COMMAND     //call command subroutine
        MOV A,#0EH        //Display on, cursor on
        ACALL COMMAND     //call command subroutine
        MOV A,#01H        //clear lcd
        ACALL COMMAND     //call command subroutine
        MOV A,#06H        //shift register right
        ACALL COMMAND      //call command subroutine
        MOV A,#80H         //cursor at line 1, position 4
        ACALL COMMAND      //call command subroutine
        ACALL DELAY        //give LCD some time
        MOV A,#'A'         //Display letter W
        ACALL DISPLAY      //call display subroutine
        ACALL DELAY        //give lcd sometime
        MOV A,#'L'         //Display Letter E
        ACALL DISPLAY      //call display subroutine
        ACALL DELAY        //give lcd sometime
        MOV A,#'C'         //Display Letter L
        ACALL DISPLAY      //call display subroutine
        ACALL DELAY        //give lcd sometime
        MOV A,#'O'         //Display Letter C
        ACALL DISPLAY       //call display subrotuine
        ACALL DELAY         //give lcd sometime
        MOV A,#'H'          //display Letter 0
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
        MOV A,#'O'          //Display Letter M
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
        MOV A,#'L'          //Display Letter E
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		MOV A,#' '          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
       MOV A,#'D'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		
        MOV A,#'E'          //Display Letter O
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY 
        MOV A,#'T'
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime        //give lcd sometime
        
        MOV A,#'E'          //Display Letter V
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
        MOV A,#'C'          //Display Letter I
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY          //give lcd sometime
        MOV A,#'T'           //Display Letter I
        ACALL DISPLAY        //call display subroutine
        ACALL DELAY          //give lcd sometime
        MOV A,#'E'           //Display Letter T
        ACALL DISPLAY        //call display subroutine
        ACALL DELAY          //give lcd sometime
		MOV A,#'D'           //Display Letter T
        ACALL DISPLAY        //call display subroutine
        ACALL DELAY          //give lcd sometime
	    MOV A,#06H        //shift register right
        ACALL COMMAND      //call command subroutine
		MOV A,#0C0H         //cursor at line 1, position 4
        ACALL COMMAND      //call command subroutine
        ACALL DELAY        //give LCD some time
        MOV A,#'Y'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		
        MOV A,#'O'          //Display Letter O
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY 
        MOV A,#'U'
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime        //give lcd sometime
        
        MOV A,#"'"          //Display Letter V
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
        MOV A,#'R'          //Display Letter I
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY          //give lcd sometime
        MOV A,#'E'           //Display Letter I
        ACALL DISPLAY        //call display subroutine
        ACALL DELAY          //give lcd sometime
        MOV A,#' '           //Display Letter T
        ACALL DISPLAY        //call display subroutine
        ACALL DELAY          //give lcd sometime
		MOV A,#'D'           //Display Letter T
        ACALL DISPLAY        //call display subroutine
        ACALL DELAY          //give lcd sometime
		MOV A,#'R'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		MOV A,#'U'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		MOV A,#'N'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		MOV A,#'K'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		MOV A,#'.'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		MOV A,#'.'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		MOV A,#'.'          //Display Letter T
        ACALL DISPLAY       //call display subroutine
        ACALL DELAY         //give lcd sometime
		RET

 AGAIN: SJMP AGAIN           //stay here
COMMAND: MOV P2,A            //copy register A to port 1
        CLR P3.5             //RS = 0 for command
        CLR P3.6             //R/W =0 for write
        SETB P3.7            //E = 1 for high pulse
        ACALL DELAY          //give lcd sometime
         CLR P3.7            //E = 0 for H-to-L pulse
         RET                 // Return to main program
 DISPLAY:MOV P2,A            //copy reg A to port1
         SETB P3.5           //RS = 1 for data
         CLR P3.6            //R/W = 0 for write
         SETB P3.7           //E = 1 for high pulse
         CALL DELAY           //give lcd sometime
         CLR P3.7            //  E = 0 for H-to-L pulse
         RET                 //Return main program



DELAY:
  MOV R4, #0FFh  ; Set the delay counter
LOOP1:
  MOV R3, #0FFh  ; Set the inner loop counter
LOOP2:
  DJNZ R3, LOOP2 ; Decrement the inner loop counter
  DJNZ R4, LOOP1 ; Decrement the delay counter
  RET


THRESHOLD:      ; The threshold value for the alcohol concentration
DB 50           ; Adjust this value as per the sensitivity of the MQ3 sensor
END