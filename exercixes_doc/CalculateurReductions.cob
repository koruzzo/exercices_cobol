IDENTIFICATION DIVISION.
PROGRAM-ID. CalculReductions.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 MontantEntre PIC 9(6)V99.
01 Reduction PIC 9(6)V99.
01 MontantFinal PIC 9(6)V99.

PROCEDURE DIVISION.
    DISPLAY "Montant du prix : "
    ACCEPT MontantEntre

    IF MontantEntre < 100 THEN
        DISPLAY "Aucune réduction possible."
    ELSE
        IF MontantEntre <= 500 THEN
            COMPUTE Reduction = MontantEntre * 0.05
        ELSE
            COMPUTE Reduction = MontantEntre * 0.10
        END-IF

        COMPUTE MontantFinal = MontantEntre - Reduction
        DISPLAY "Vous avez une réduction de ", Reduction, "appliquée."
    END-IF

    DISPLAY "Montant de la réduction appliquée: ", Reduction
    DISPLAY "Montant final à payer : ", MontantFinal

    STOP RUN.
