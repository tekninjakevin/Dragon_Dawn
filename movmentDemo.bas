CLS
row = 12
column = 40
DO
    DO: REM &lt;this loop waits for a key to be pressed
        keyed$ = INKEY$
    LOOP UNTIL keyed$ <> ""
    LOCATE row, column
    PRINT " ": REM this erases the "C"
    IF keyed$ = "w" THEN row = row - 1
    IF keyed$ = "s" THEN row = row + 1
    IF keyed$ = "a" THEN column = column - 1
    IF keyed$ = "d" THEN column = column + 1
    LOCATE row, column
    PRINT "@": REM shows the "@" at the new position
LOOP

