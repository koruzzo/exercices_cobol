IDENTIFICATION DIVISION.
PROGRAM-ID. helloworld2.

ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
  01 premierevariable PIC 9 VALUE ZERO.

PROCEDURE DIVISION.
  PERFORM FIRST-PARA
  PERFORM SECOND-PARA
  PERFORM THIRD-PARA
  STOP RUN.

FIRST-PARA.
  DISPLAY "Premier paragraphe".
  ADD 1 TO premierevariable.
  DISPLAY "valeur:" premierevariable.
THIRD-PARA.
  DISPLAY "Troisième paragraphe".
  ADD 3 TO premierevariable.
  DISPLAY "valeur:" premierevariable.
SECOND-PARA.
  DISPLAY "Deuxième paragraphe".
  ADD 2 TO premierevariable.
  DISPLAY "valeur:" premierevariable.
