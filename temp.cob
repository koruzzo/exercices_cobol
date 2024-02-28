IDENTIFICATION DIVISION.
PROGRAM-ID. GestionCompte.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
  SELECT historique ASSIGN TO "historique.txt"
  ORGANIZATION IS LINE SEQUENTIAL.
           
  SELECT solde ASSIGN TO "solde.txt"
  ORGANIZATION IS LINE SEQUENTIAL.


DATA DIVISION.

FILE SECTION.
FD historique.
  01 HistoriqueRecord.
    05 HistoriqueDescrp PIC X(50).
    05 HistoriqueVal PIC 9(10)V99.
FD solde.
  01 SoldeRecord.
    05 SoldeVal PIC 9(10)V99.

WORKING-STORAGE SECTION.
01 SoldeCompteA PIC 9(6)V99 VALUE 1521.20.
01 SoldeCompteB PIC 9(6)V99 VALUE 1705.45.

01 Depot PIC 9(6)V99.
01 Retrait PIC 9(6)V99.
01 Virement PIC 9(6)V99.

01 Choix PIC X(1).

PROCEDURE DIVISION.
  DISPLAY "Début du programme de gestion de compte bancaire."

  PERFORM OPERATIONS UNTIL Choix = 'E'.

  DISPLAY "Fin du programme !"

  STOP RUN.

OPERATIONS.
  DISPLAY "---------------------------------------------------"
  DISPLAY "Quel type d'opération souhaitez-vous effectuer ?"
  DISPLAY "D -> Déposer de l'argent"
  DISPLAY "R -> Retirer de l'argent"
  DISPLAY "V -> Effectuer un virement vers le compte B"
  DISPLAY "S -> Afficher le solde du compte A"
  DISPLAY "E -> Quitter"
  DISPLAY "---------------------------------------------------"

  ACCEPT Choix

  EVALUATE Choix
    WHEN 'D'
      DISPLAY "Entrez le montant à déposer : "
      ACCEPT Depot
      COMPUTE SoldeCompteA = SoldeCompteA + Depot
      DISPLAY "Dépôt effectué avec succès."
      DISPLAY "Nouveau solde : " SoldeCompteA "€."
      OPEN OUTPUT historique
      MOVE "Depot :" TO HistoriqueDescrp
      MOVE Depot TO HistoriqueVal
      WRITE HistoriqueRecord
      CLOSE historique.
           
      OPEN OUTPUT solde
      MOVE SoldeRecord-SoldeCompteA TO SoldeVal
      WRITE SoldeRecord
      CLOSE solde.
      DISPLAY "---------------------------------------------------"

    WHEN 'R'
      DISPLAY "Entrez le montant à retirer : "
      ACCEPT Retrait
      IF Retrait > SoldeCompteA THEN
        DISPLAY "Solde insuffisant."
        DISPLAY "Votre solde actuelle: " SoldeCompteA "€."
        DISPLAY "---------------------------------------------------"
      ELSE
        COMPUTE SoldeCompteA = SoldeCompteA - Retrait
        DISPLAY "Retrait effectué avec succès."
        DISPLAY "Nouveau solde : " SoldeCompteA "€."
        DISPLAY "---------------------------------------------------"
      END-IF

    WHEN 'V'
      DISPLAY "Entrez le montant à transférer : "
      ACCEPT Virement
      IF Virement > SoldeCompteA THEN
        DISPLAY "Solde insuffisant."
        DISPLAY "Votre solde actuelle: " SoldeCompteA "€."
        DISPLAY "---------------------------------------------------"
      ELSE
        COMPUTE SoldeCompteA = SoldeCompteA - Virement
        COMPUTE SoldeCompteB = SoldeCompteB + Virement
        DISPLAY "Virement effectué avec succès."
        DISPLAY "Nouveau solde : " SoldeCompteA "€."
        DISPLAY "Solde compte B: " SoldeCompteB "€."
        DISPLAY "---------------------------------------------------"
      END-IF

    WHEN 'S'
      DISPLAY "Vous avez : " SoldeCompteA "€ sur votre compte."

    WHEN 'E'
      CONTINUE

    WHEN OTHER
      DISPLAY "Choix invalide ou mal écrit. Veuillez entrer un choix valide."

  END-EVALUATE.
