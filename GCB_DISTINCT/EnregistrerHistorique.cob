IDENTIFICATION DIVISION.
PROGRAM-ID. EnregistrerHistorique.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
  SELECT historique ASSIGN TO "historique.txt"
      ORGANIZATION IS LINE SEQUENTIAL
      ACCESS MODE IS SEQUENTIAL
      FILE STATUS IS WS-HIST-STATUS.

DATA DIVISION.

FILE SECTION.
FD historique.
01 HistoriqueRecord.
   05 HistoriqueDescrp PIC X(1).
   05 MYFILLER_H1  PIC X(21).
   05 HistoriqueValA PIC 9(10)V99.
   05 MYFILLER_H2  PIC X(32).
   05 HistoriqueValB PIC 9(10)V99.

WORKING-STORAGE SECTION.
01 WS-HIST-STATUS PIC XX.

LINKAGE SECTION.
01 SoldeCompteA PIC 9(6)V99.
01 SoldeCompteB PIC 9(6)V99.
01 Depot PIC 9(6)V99.
01 Retrait PIC 9(6)V99.
01 Virement PIC 9(6)V99.
01 Choix PIC X(1).

PROCEDURE DIVISION USING SoldeCompteA SoldeCompteB Depot Retrait Virement Choix.
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
