IDENTIFICATION DIVISION.
PROGRAM-ID. Books.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 Livres.
   02 Livre OCCURS 5 Times INDEXED BY Idx.
      05 Titre             PIC X(25).
      05 Auteur            PIC X(25).
      05 AnneePublication PIC 9(4).
      05 NbCopies          PIC 9(3).

PROCEDURE DIVISION.
   PERFORM INITIALISATION.
   PERFORM AFFICHER-LIVRES.
   STOP RUN.

INITIALISATION.
   MOVE "1984" TO Titre (1).
   MOVE "George Orwell" TO Auteur (1).
   MOVE 1949 TO AnneePublication (1).
   MOVE 5 TO NbCopies (1).

   MOVE "Le Petit Prince" TO Titre (2).
   MOVE "Antoine de Saint-Exupéry" TO Auteur (2).
   MOVE 1943 TO AnneePublication (2).
   MOVE 3 TO NbCopies (2).

   MOVE "Le Seigneur des Anneaux" TO Titre (3).
   MOVE "J.R.R. Tolkien" TO Auteur (3).
   MOVE 1954 TO AnneePublication (3).
   MOVE 7 TO NbCopies (3).

   MOVE "Fondation" TO Titre (4).
   MOVE "Isaac Asimov" TO Auteur (4).
   MOVE 1951 TO AnneePublication (4).
   MOVE 4 TO NbCopies (4).

   MOVE "Dune" TO Titre (5).
   MOVE "Frank Herbert" TO Auteur (5).
   MOVE 1965 TO AnneePublication (5).
   MOVE 6 TO NbCopies (5).

AFFICHER-LIVRES.
   MOVE 1 TO Idx.
   DISPLAY "Inventaire des Livres :".
   PERFORM VARYING Idx FROM 1 BY 1 UNTIL Idx > 5
      DISPLAY "Titre : ", Titre(Idx)
      DISPLAY "Auteur : ", Auteur(Idx)
      DISPLAY "Année de Publication : ", AnneePublication(Idx)
      DISPLAY "Nombre de Copies : ", NbCopies(Idx)
      DISPLAY "-----------------------------------------------"
   END-PERFORM.
