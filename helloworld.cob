IDENTIFICATION DIVISION.
PROGRAM-ID. helloworld.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
 01 premierevariable PIC 9 VALUE ZERO.
PROCEDURE DIVISION.
 DISPLAY "helloworld".
 DISPLAY "valeur:" premierevariable.
 MOVE 2 TO premierevariable.
 DISPLAY "valeur:" premierevariable.