IDENTIFICATION DIVISION.
PROGRAM-ID. Depot.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
  
DATA DIVISION.

LINKAGE SECTION.
01 SoldeCompteA PIC 9(6)V99.
01 SoldeCompteB PIC 9(6)V99.
01 Depot PIC 9(6)V99.
01 Retrait PIC 9(6)V99.
01 Virement PIC 9(6)V99.
01 Choix PIC X(1).

PROCEDURE DIVISION USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix.
  DISPLAY "Entrez le montant à déposer : "
  ACCEPT Depot
  COMPUTE SoldeCompteA = SoldeCompteA + Depot
  DISPLAY "Dépôt effectué avec succès."
  DISPLAY "Nouveau solde : " SoldeCompteA "€."
  CALL 'EnregistrerHistorique' USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix
  CALL 'EnregistrerSolde' USING SoldeCompteA SoldeCompteB.
