IDENTIFICATION DIVISION.
PROGRAM-ID. GestionCompteEF.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
  SELECT historique ASSIGN TO "historique.txt"
      ORGANIZATION IS LINE SEQUENTIAL
      ACCESS MODE IS SEQUENTIAL
      FILE STATUS IS WS-HIST-STATUS.

  SELECT solde ASSIGN TO "solde.txt"
      ORGANIZATION IS LINE SEQUENTIAL
      ACCESS MODE IS SEQUENTIAL
      FILE STATUS IS WS-SOLDE-STATUS.

DATA DIVISION.

FILE SECTION.
FD historique.
01 HistoriqueRecord.
   05 HistoriqueDescrp PIC X(1).
   05 MYFILLER_H1  PIC X(21).
   05 HistoriqueValA PIC 9(10)V99.
   05 MYFILLER_H2  PIC X(32).
   05 HistoriqueValB PIC 9(10)V99.

FD solde.
01 SoldeRecord.
   05 MYFILLER_S1  PIC X(10).
   05 SoldeValA PIC 9(10)V99.
   05 MYFILLER_S2  PIC X(2).
   05 MYFILLER_S3  PIC X(10).
   05 SoldeValB PIC 9(10)V99.
   05 MYFILLER_S4  PIC X(2).

WORKING-STORAGE SECTION.
01 SoldeCompteA PIC 9(6)V99 VALUE 1521.20.
01 SoldeCompteB PIC 9(6)V99 VALUE 1705.45.

01 Depot PIC 9(6)V99.
01 Retrait PIC 9(6)V99.
01 Virement PIC 9(6)V99.

01 DisplayAffichage PIC X(100) VALUE "---------------------------------------------------".
01 Choix PIC X(1).

01 WS-HIST-STATUS PIC XX.
01 WS-SOLDE-STATUS PIC XX.

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
  PERFORM ENREGISTRER-HISTORIQUE
  PERFORM ENREGISTRER-SOLDE.

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
    PERFORM ENREGISTRER-HISTORIQUE
    PERFORM ENREGISTRER-SOLDE
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
    PERFORM ENREGISTRER-HISTORIQUE
    PERFORM ENREGISTRER-SOLDE
  END-IF.

AFFICHER-SOLDE.
  DISPLAY "Vous avez : " SoldeCompteA "€ sur votre compte."
  DISPLAY "Solde compte B: " SoldeCompteB "€."
  PERFORM ENREGISTRER-HISTORIQUE.

ENREGISTRER-HISTORIQUE.
  IF WS-HIST-STATUS = "00" OR WS-HIST-STATUS = "97" THEN
      OPEN EXTEND historique
  ELSE
      OPEN OUTPUT historique
  END-IF

  MOVE Choix TO HistoriqueDescrp

  EVALUATE HistoriqueDescrp
    WHEN 'D'
      MOVE ": Valeur operation ->" TO MYFILLER_H1
      MOVE Depot TO HistoriqueValA
      MOVE ", Nouvelle valeur solde cible ->" TO MYFILLER_H2
      MOVE SoldeCompteA TO HistoriqueValB
    WHEN 'R'
      MOVE ": Valeur operation ->" TO MYFILLER_H1
      MOVE Retrait TO HistoriqueValA
      MOVE ", Nouvelle valeur solde cible ->" TO MYFILLER_H2
      MOVE SoldeCompteA TO HistoriqueValB
    WHEN 'V'
      MOVE ": Valeur operation ->" TO MYFILLER_H1
      MOVE Virement TO HistoriqueValA
      MOVE ", Nouvelle valeur solde cible ->" TO MYFILLER_H2
      MOVE SoldeCompteA TO HistoriqueValB
    WHEN 'S'
      MOVE ": Valeur solde A --->" TO MYFILLER_H1
      MOVE SoldeCompteA TO HistoriqueValA
      MOVE ", Valeur solde B -------------->" TO MYFILLER_H2
      MOVE SoldeCompteB TO HistoriqueValB
    WHEN OTHER
      DISPLAY "Choix invalide."
  END-EVALUATE.

  WRITE HistoriqueRecord
  CLOSE historique.

ENREGISTRER-SOLDE.
  OPEN OUTPUT solde
  MOVE "Solde A : " TO MYFILLER_S1
  MOVE SoldeCompteA TO SoldeValA
  MOVE ". " TO MYFILLER_S2
  MOVE "Solde B : " TO MYFILLER_S3
  MOVE SoldeCompteB TO SoldeValB
  MOVE ". " TO MYFILLER_S4
  WRITE SoldeRecord
  CLOSE solde.
