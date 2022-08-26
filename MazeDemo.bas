CLS

DIM maze$(6)
maze$(1) = 	"##################################################"
maze$(2) = 	"#.......#......#......#........#...#...#.....#...#"
maze$(3) = 	"#.#.#.#.....#..#..#...#.#.#.#.#..........#.......#"
maze$(4) = 	"#.#...#.#.........#...,.#.#.#...#..#...#.#...#.#.#"
maze$(5) = 	"#...#...#...#..#..#..##...#.#.###.##..##..#..#.#.#"
maze$(6) = 	"#.,,,,####.##..#..#...#..##.#.#.......#...#..#.#.#"
maze$(7) = 	"#...#.#.....#..#....#.#.....#.#...##..#.#.#......#"
maze$(8) = 	"#.#.#.#..#..#.....#.#.#..#..#.#....#..#.#.#..###.#"
maze$(9) = 	"#...#.##.#.....#..#...#..#..#.#.####....#.#..###.#"
maze$(10) = 	"#.#.#....#....#...#.....##....#.#..#..#.#.#..###.#"
maze$(11) = 	"#.#...####...####.#.###..#.#.#..##.#.##.#.#......#"
maze$(12) = 	"#.#.#.#.#..#.#........#.##.#.#.##..#.#....#..#.#.#"
maze$(13) = 	"#...#.#.#.##.########.#.#....#.#..##.#....#..#.#.#"
maze$(14) = 	"##################################################"
row = 5
column = 3
dots = 51: REM new
DO
    LOCATE 1, 1
    FOR count = 1 TO 14
        PRINT maze$(count)
    NEXT count
    LOCATE row, column
    PRINT "@"
    : REM new
    IF dots = 0 THEN
        LOCATE 8, 1: REM
        PRINT "You have won!": REM
        END: REM
    END IF: REM
    DO
        keyed$ = INKEY$
    LOOP UNTIL keyed$ <> ""
    oldRow = row
    oldColumn = column
    IF keyed$ = "w" THEN row = row - 1
    IF keyed$ = "s" THEN row = row + 1
    IF keyed$ = "a" THEN column = column - 1
    IF keyed$ = "d" THEN column = column + 1
    IF MID$(maze$(row), column, 1) = "#" THEN
        row = oldRow
        column = oldColumn
    END IF
    : REM new
    IF MID$(maze$(row), column, 1) = "." THEN
        MID$(maze$(row), column, 1) = " ": REM
        dots = dots - 1: REM
    END IF: REM
LOOP

