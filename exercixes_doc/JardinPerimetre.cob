IDENTIFICATION DIVISION.
PROGRAM-ID. CalculPerimetre.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
DATA DIVISION.
  WORKING-STORAGE SECTION.
    01 Longueur PIC 9(5).
    01 Largeur PIC 9(5).
    01 Perimetre PIC 9(9).
PROCEDURE DIVISION.
  DISPLAY "Calcul du périmètre du jardin.".
  DISPLAY "Entrez la longueur du jardin.".
  ACCEPT Longueur.
  DISPLAY "Entrez la largeur du jardin.".
  ACCEPT Largeur.
  COMPUTE Perimetre = 2 * (Longueur + Largeur).
  DISPLAY "Le périmètre est :", Perimetre.
  STOP RUN.
