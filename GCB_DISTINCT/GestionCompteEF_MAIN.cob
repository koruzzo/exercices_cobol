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
      PERFORM O-DEPOT
    WHEN 'R'
      PERFORM O-RETRAIT
    WHEN 'V'
      PERFORM O-VIREMENT
    WHEN 'S'
      PERFORM AFFICHER-SOLDE
    WHEN 'E'
      CONTINUE
    WHEN OTHER
      DISPLAY "Choix invalide ou mal écrit. Veuillez entrer un choix valide."
  END-EVALUATE.

O-DEPOT.
  DISPLAY "Entrez le montant à déposer : "
  ACCEPT Depot
  COMPUTE SoldeCompteA = SoldeCompteA + Depot
  DISPLAY "Dépôt effectué avec succès."
  DISPLAY "Nouveau solde : " SoldeCompteA "€."
  CALL 'EnregistrerHistorique' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
  CALL 'EnregistrerSolde' USING SoldeCompteA SoldeCompteB.

O-RETRAIT.
  DISPLAY "Entrez le montant à retirer : "
  ACCEPT Retrait
  IF Retrait > SoldeCompteA THEN
    DISPLAY "Solde insuffisant."
    DISPLAY "Votre solde actuelle: " SoldeCompteA "€."
  ELSE
    COMPUTE SoldeCompteA = SoldeCompteA - Retrait
    DISPLAY "Retrait effectué avec succès."
    DISPLAY "Nouveau solde : " SoldeCompteA "€."
    CALL 'EnregistrerHistorique' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
    CALL 'EnregistrerSolde' USING SoldeCompteA SoldeCompteB
  END-IF.

O-VIREMENT.
  DISPLAY "Entrez le montant à transférer : "
  ACCEPT Virement
  IF Virement > SoldeCompteA THEN
    DISPLAY "Solde insuffisant."
    DISPLAY "Votre solde actuelle: " SoldeCompteA "€."
  ELSE
    COMPUTE SoldeCompteA = SoldeCompteA - Virement
    COMPUTE SoldeCompteB = SoldeCompteB + Virement
    DISPLAY "Virement effectué avec succès."
    DISPLAY "Nouveau solde : " SoldeCompteA "€."
    DISPLAY "Solde compte B: " SoldeCompteB "€."
    CALL 'EnregistrerHistorique' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
    CALL 'EnregistrerSolde' USING SoldeCompteA SoldeCompteB
  END-IF.

AFFICHER-SOLDE.
  DISPLAY "Vous avez : " SoldeCompteA "€ sur votre compte."
  DISPLAY "Solde compte B: " SoldeCompteB "€."
  CALL 'EnregistrerHistorique' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix.
