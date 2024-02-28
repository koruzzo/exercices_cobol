IDENTIFICATION DIVISION.
PROGRAM-ID. Books_2.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 Livres.
   02 Livre OCCURS 10 Times INDEXED BY Idx.
      05 Titre PIC X(25).
      05 Auteur PIC X(25).
      05 AnneePublication PIC 9(4).
      05 NbCopies PIC 9(3).
      
   01 NombreLivres PIC 9(2).
   01 LivreCount PIC 9(2).

PROCEDURE DIVISION.
   PERFORM INITIALISATION.
   PERFORM SAISIR-LIVRES.
   PERFORM AFFICHER-LIVRES.
   STOP RUN.

INITIALISATION.
   MOVE 0 TO LivreCount.

SAISIR-LIVRES.
   DISPLAY "Combien de livres voulez-vous entrer ?"
   ACCEPT NombreLivres
   PERFORM VARYING Idx FROM 1 BY 1 UNTIL Idx > NombreLivres
      ADD 1 TO LivreCount
      DISPLAY "Entrez le titre pour le livre ", LivreCount
      ACCEPT Titre(LivreCount)
      DISPLAY "Entrez le nom de l'auteur pour le livre ", LivreCount
      ACCEPT Auteur(LivreCount)
      DISPLAY "Entrez l'annee de publication pour le livre ", LivreCount
      ACCEPT AnneePublication(LivreCount)
      DISPLAY "Entrez le nbCopie pour le livre ", LivreCount
      ACCEPT NbCopies(LivreCount)
   END-PERFORM.

AFFICHER-LIVRES.
   MOVE 1 TO Idx.
   DISPLAY "Inventaire des Livres :"
   PERFORM VARYING Idx FROM 1 BY 1 UNTIL Idx > LivreCount
      DISPLAY "Titre : ", Titre(Idx)
      DISPLAY "Auteur : ", Auteur(Idx)
      DISPLAY "Année de Publication : ", AnneePublication(Idx)
      DISPLAY "Nombre de Copies : ", NbCopies(Idx)
      DISPLAY "-----------------------------------------------"
   END-PERFORM.
