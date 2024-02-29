IDENTIFICATION DIVISION.
PROGRAM-ID. GestionCompteEF.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.

DATA DIVISION.

WORKING-STORAGE SECTION.
01 DisplayAffichage PIC X(100) VALUE "---------------------------------------------------".

01 SoldeCompteA PIC 9(6)V99 VALUE 1521.20.
01 SoldeCompteB PIC 9(6)V99 VALUE 1705.45.
01 Depot PIC 9(6)V99.
01 Retrait PIC 9(6)V99.
01 Virement PIC 9(6)V99.
01 Choix PIC X(1).

PROCEDURE DIVISION.
  DISPLAY "Début du programme de gestion de compte bancaire."

  PERFORM NOUVELLE-OPERATION UNTIL Choix = 'E'.

  DISPLAY "Fin du programme !"

  STOP RUN.

NOUVELLE-OPERATION.
  DISPLAY DisplayAffichage
  DISPLAY "Quel type d'opération souhaitez-vous effectuer ?"
  DISPLAY "D -> Déposer de l'argent"
  DISPLAY "R -> Retirer de l'argent"
  DISPLAY "V -> Effectuer un virement vers le compte B"
  DISPLAY "S -> Afficher le solde du compte A"
  DISPLAY "E -> Quitter"
  DISPLAY DisplayAffichage

  ACCEPT Choix

  EVALUATE Choix
    WHEN 'D'
      CALL 'Depot' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
    WHEN 'R'
      CALL 'Retrait' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
    WHEN 'V'
      CALL 'Virement' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
    WHEN 'S'
      CALL 'AfficherSolde' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
    WHEN 'E'
      CONTINUE
    WHEN OTHER
      DISPLAY "Choix invalide ou mal écrit. Veuillez entrer un choix valide."
  END-EVALUATE.
