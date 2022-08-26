


'Features For Future Versions
'Races And Classes
'Point Based Stats System






'------------------------Setup Variables,Types ,Constants'
'on demand random retraceable maze
Type Roomlook
    up As _Byte
    down As _Byte
    left As _Byte
    right As _Byte
End Type
 
Type room
    North As Integer 'what room lies in direction
    South As Integer
    East As Integer
    West As Integer
    Walls As Roomlook 'walls or passages
    Created As _Byte 'as this room been visited?
End Type


Color 15
Dim Shared MonsterName$, RandomEnconter$, FightORrun$, Kobold$
Dim Shared Maze(32000) As room, a$, b$, c$(1), d$(5), e$(1)
Dim Shared lastmade%, wall$(3), enconter, CharName$, Monstercount%, MonsterGold%, Herb%
Dim Shared gold%, MaxHealth%, Health%, Experance%, Lvl%, WeaponBonus%, item$, Personalitem$
Dim Shared Itemclass$, itemName$, itemRoom1, Inventory$, herbonground$, bunny$
Dim Shared MonsterHealth%, MonsterExp%
Dim Shared MonsterHit%
Dim Shared id%, AB%
Dim Shared KingKobold$, MonsterTitle$, LizardMen$
Dim Shared HerbCount%
Dim Shared Race$, Class$
Const TRUE = -1, FALSE = Not TRUE
Const UP = 1, DOWN = 2, LEFT = 3, RIGHT = 4


a$ = "To the "
b$ = " there is a "
c$(0) = "wall": c$(1) = "passage"
d$(UP) = "north": d$(DOWN) = "south": d$(LEFT) = "west": d$(RIGHT) = "east"
e$(0) = "unknown": e$(1) = "known"
herd = 0
itemRoom2 = TRUE
'Starting Charcter stats
Lvl% = 1
itemRoom1 = TRUE
Trap = 1
MaxHealth% = 50
Health% = MaxHealth%
WeaponBonus% = 1
'Screen _NewImage(800, 500, 32)
'----------Monster's---------------

Dim LizardMan$(10)

LizardMan$(1) = "       (__) "
LizardMan$(2) = "       (--) "
LizardMan$(3) = "      /-\/-\"
LizardMan$(4) = "     / | ~| \"
LizardMan$(5) = "    ^  |  |  ^"
LizardMan$(6) = "       |  |"
LizardMan$(7) = "      /----\"
LizardMan$(8) = "     /      \"
LizardMan$(9) = "    ^        ^"
LizardMan$(10) = "--------------------"

Dim Zulu$(13)

Zulu$(1) = "    \\\|||///"
Zulu$(2) = "  .  ======= "
Zulu$(3) = " / \| O   O |"
Zulu$(4) = " \ / \`___'/"
Zulu$(5) = "  #   _| |_ "
Zulu$(6) = " (#) (     )"
Zulu$(7) = "  #\//|* *|\\"
Zulu$(8) = "  #\/(  *  )/"
Zulu$(9) = "  #   ====="
Zulu$(10) = " #   ( U ) "
Zulu$(11) = " #   || ||"
Zulu$(12) = ".#---'| |`----."
Zulu$(13) = "`#----' `-----'"

Dim FlamDemon$(20)




Kobold$(1) = "       ___   "
Kobold$(2) = "     {~._.~} |"
Kobold$(3) = "      ( Y )  | "
Kobold$(4) = "     ()~*~~~()"
Kobold$(5) = "     (_)-(_) |"
Kobold$(6) = "--------------------"

' The Bunny of Doom
Dim Bunny$(20)

Bunny$(1) = "            ,"
Bunny$(2) = "            /|      __ "
Bunny$(3) = "           / |   ,-~ / "
Bunny$(4) = "          Y :|  //  /  "
Bunny$(5) = "          | jj /( .^   "
Bunny$(6) = "          >-#~#-vY"
Bunny$(7) = "         /       Y"
Bunny$(8) = "        jo  o    |"
Bunny$(9) = "       ( ~T~     j"
Bunny$(10) = "       >._-' _./ "
Bunny$(11) = "      /   #~#  |"
Bunny$(12) = "      Y     _,  | "
Bunny$(13) = "     /| ;-#~ _  l "
Bunny$(14) = "    / l/ ,-#~    \ "
Bunny$(15) = "    \//\/      .- \ "
Bunny$(16) = "     Y        /    y"
Bunny$(17) = "     l       I     ! "
Bunny$(18) = "     ]\      _\    /##"
Bunny$(19) = "    (# ~----( ~   Y.  )"
Bunny$(20) = "~~~~~~~~~~~~~~~~~~~~~~~~~"


'For count = 1 To 20
'Print Bunny$(count)
'Next count

Cls
'Do: Key$ = InKey$: Loop Until Key$ = Chr$(13) ' Loop until Press Enter



Cls
ClearMaze 'make maze ready to explore
makerooms 'premake some wall sections
Randomize Timer

'create the starting room
'pick which walls you can pass
Maze(0).Walls.up = Int(Rnd * 2)
Maze(0).Walls.down = Int(Rnd * 2)
Maze(0).Walls.left = Int(Rnd * 2)
Maze(0).Walls.right = Int(Rnd * 2)
Maze(0).Created = TRUE

current% = 0 'room player is in
lastmade% = 0 'last room created
'---------------------------------------End of game Setup-----------------------------------------
'---------------------------------------Start of Game---------------------------------------------
TitleScreen:
Cls
Print "                                                         _____------------___"
Print "                                                    ._--':::::'-------____"
Print "                .___------__       /-.._.    _---_ '|:::::::::::::::::::::---"
Print "           ._--'.---::::::/ `      \ .-. '-'' *__*|/:::::::::::::::::::::::::"
Print "      .__-'  _-'::::::::/ ._------_| '_'  __--' _'/::::::::::::::::::::::::::"
Print "  _--'    _-'::::::::::|.'  ._----_\    -'  ._-':::::::::::::::::::::::::::::"
Print "       _-':::::::::::::\  .'       /  .__--' -':::::::::_--_:::::::::::.-----"
Print "   _-'::::::::::::::::::-_|       /    /   /::::::::::/      \:::::::/"
Print "  '::::::::::::::::::::::::----__-   .   .  |.--_:::/          \:::/"
Print " .----_::::::::::::::::::::/                \  \\ \/             \/"
Print "| ._.-_'-_:::.----.:::.:. . .    .         . |  \\"
Print " -_. -.\  \ .-.----..-----. .----. .---. .-.----:|\"
Print "  | | | |  | | .-. ||._-  || .-. || .-. | | .-. |\|"
Print " .| |/__/  / | |  - .'.-. || '_' || | | | | | | |"
Print "|       ._- .| |.   | '-' |'___. || '_' |.| |.| |."
Print " -------    '---'    '----:--._| | '---' '---'---'"
Print "                          '______'.----_"
Print "                                  | ._.-_'-_"
Print "                                   -_. -.\  \ .-----. ----..---------.-.----."
Print "                                    | | | |  ||._-  |  \  \'/ \'\  /  | .-. |"
Print "                                   .| |/__/  /.'.-. |   \  ' . '' /   | | | |"
Print "                                  |       ._- | '-' |    \  / \  /   .| |.| |."
Print "                                   -------     '----'     ''   ''    '---'---'"
'-----------------------------------------------------------------------------
Print "By Kevin Tangreen"
Locate 27, 35: Print "Press Press Enter "
Do: Key$ = InKey$: Loop Until Key$ = Chr$(13) ' Loop until Press Enter
Cls
Locate 10, 20
Print "²²²²²²²²²²²²²²²²²²²²²²²²²²"
Locate 11, 20
Print "² Welcome to dragon Dawn ²"
Locate 12, 20
Print "²²²²²²²²²²²²²²²²²²²²²²²²²²"


Locate 14, 8: Print "What is Name";
Input CharName$
Cls
Locate 3, 19: Print "What Race Are You"
Locate 5, 20: Print "(H)uman"
Locate 6, 20: Print "(D)rafs"
Locate 7, 20: Print "(E)lf"
Locate 8, 20: Print "H(o)bet"
Do '
    keyed$ = InKey$
Loop Until keyed$ <> ""

Select Case keyed$
    Case "h"
        Race$ = "Human"
    Case "d"
        Race$ = "Dwarve"
    Case "e"
        Race$ = "Elf"

End Select



Cls
Locate 14, 15
Print "Press Enter To Roll Stats"
Do: Key$ = InKey$: Loop Until Key$ = Chr$(13) ' Loop until Press Enter
Cls
Locate 3, 10:
'Roll Stats
RollStats:
Print "Your Stats have been rolled "
Print " "
strength% = Int(Rnd * 20) + 5
intelligence% = Int(Rnd * 20) + 5
wisdom% = Int(Rnd * 20) + 5
dex% = Int(Rnd * 20) + 5
vitality% = Int(Rnd * 20) + 5
charisma% = Int(Rnd * 20) + 5
luck% = Int(Rnd * 100) + 1
HitPoints% = Int(Rnd * 10) + 5

If Race$ = "Dwrave" Then
    Strenght% = Strenght% + 10
End If
If Race$ = " Elf" Then
    intelligence% = intelligence% + 5
End If
Locate 5, 20: Print "Strength = ", strength%
Locate 6, 20: Print "Intelligence% = ", intelligence%
Locate 7, 20: Print "Wisdom = ", wisdom%
Locate 8, 20: Print "Dexterity = ", dex%
Locate 9, 20: Print "Vitality = ", vitality%
Locate 10, 20: Print "Charisma = ", charisma%
Locate 11, 20: Print "Luck = ", luck%

If Stregth <= 11 Then Wieghtallow% = 200
If strength% >= 12 Then Wieghtallow% = 300
If stregrh% >= 16 Then Wieghtallow% = 400

If strength% <= 15 Then MaxHealth = MaxHealth + 5
If Strenght% <= 10 Then AB% = AB% + 1
If strength% <= 15 Then AB% = AB% + 4
Print
Print "R) Re-Roll Abilitie Scores"
Print "K) Keep Abilitie Scores"
Do '
    keyed$ = InKey$
Loop Until keyed$ <> ""
Print
If keyed$ = "k" Then GoTo Main_Game
If keyed$ = "r" Then GoTo RollStats
ChooseClass:
Cls


Main_Game:
Cls

Do 'Start of main Program loop
    MAIN_LOOP:

    Locate 8, , 0 ' turn cursor off
    RandomEnconterGen (id%)
    drawroom current%
    drawstats
    DescribeRoom current%
    MessageHandler e$
    Levelup
    'itemsList
    _KeyClear 'Clear Keyboard Buffer

    Do ' Wait For Player To hit a key
        kbd& = _KeyHit
        _Delay .05
    Loop Until kbd&

    Select Case kbd&
        Case 18432 'up
            MessageHandler "You head north..."
            If Maze(current%).Walls.up Then 'if you can go up
                If Maze(current%).North >= 0 Then 'is north already referenced
                    MessageHandler "you have been here before"
                    current% = Maze(current%).North
                Else 'never been north in this room
                    MessageHandler "you find somewhere new"
                    lastmade% = lastmade% + 1
                    nul% = CreateRoom(lastmade%, current%, UP)
                    current% = lastmade%
                End If
            End If
        Case 20480 'down
            MessageHandler "You head south..."
            If Maze(current%).Walls.down Then 'if you can go down
                If Maze(current%).South >= 0 Then 'is south already referenced
                    MessageHandler "you have been here before"
                    current% = Maze(current%).South
                Else 'never been south in this room
                    MessageHandler "you find somewhere new"
                    lastmade% = lastmade% + 1
                    nul% = CreateRoom(lastmade%, current%, DOWN)
                    current% = lastmade%
                End If
            End If
        Case 19200 'left
            MessageHandler "You head west..."
            If Maze(current%).Walls.left Then 'if you can go left
                If Maze(current%).West >= 0 Then 'is west already referenced
                    MessageHandler "you have been here before"
                    current% = Maze(current%).West
                Else 'never been west in this room
                    MessageHandler "you find somewhere new"
                    lastmade% = lastmade% + 1
                    nul% = CreateRoom(lastmade%, current%, LEFT)
                    current% = lastmade%
                End If
            End If
        Case 19712 'right
            MessageHandler "You head east..."
            If Maze(current%).Walls.right Then 'if you can go right
                If Maze(current%).East >= 0 Then 'is east already referenced
                    MessageHandler "you have been here before"
                    current% = Maze(current%).East
                Else 'never been north in this room
                    MessageHandler "you find somewhere new"
                    lastmade% = lastmade% + 1
                    nul% = CreateRoom(lastmade%, current%, RIGHT)
                    current% = lastmade%
                End If
            End If
        Case 27 'ESC
            MessageHandler "You Quit"
            exitFlag% = TRUE
            End
            kbd2& = _KeyHit
            Select Case kbd&
                Case 121
                    exitFlag% = FALSE
            End Select

        Case 114 'r

            For FGT = 0 To 2
                Select Case enconter
                    Case TRUE
                        Chanceofescape = Int(Rnd * 5)
                        Select Case Chanceofescape
                            Case Is > 3
                                MessageHandler "You Run And Escape The Monster"
                                fight = FALSE
                                enconter = FALSE
                                current% = lastmade%
                                GoTo escexit
                            Case Is < 3

                                MessageHandler "your way is blocked"
                                RandomEnconterGen (id%)
                                GoTo thefight
                        End Select

                        enconter = FALSE
                        current% = lastmade%
                    Case FALSE
                        MessageHandler "What are you Running From?"
                        current% = lastmade%


                End Select

            Next FGT
        Case 102
            If enconter = TRUE Then
                Cls
                Select Case MonsterName$
                    Case "Kobold"
                        'If MonsterName$ = "Kobold$" Then

                        For count1 = 1 To 6 'Draw Kobold

                            Print Kobold$(count1)
                        Next count1
                        MonsterAttack = 5
                        MonsterTilte$ = "Kobold"
                        'End If
                    Case "King Kobold"
                        MonsterTitle$ = "King Kobold"
                        For Count2 = 1 To 6
                            Print Kobold$(Count2)
                        Next Count2
                        MonsterAttack = 6
                    Case "Lizard Man"
                        For Count3 = 1 To 10
                            Print LizardMan$(Count3)
                        Next Count3
                        MonsterTitle$ = "Lizard Man"
                    Case "Bunny"
                        'If MonsterName$ = "Bunny$" Then
                        For Count4 = 1 To 20
                            Print Bunny$(Count4)
                        Next Count4
                    Case "Zulu Warrior"
                        For Count5 = 1 To 13
                            Print Zulu$
                        Next Count5
                        'End If
                End Select

                thefight:
                drawstats


                ' Do: Key$ = InKey$: Loop Until Key$ = Chr$(32) ' Loop until Press Enter



                Do While ((MonsterHealth% > 0) And (Health% > 0))
                    Color 15
                    MessageHandler "Press R to run "
                    MessageHandler "Any other key to attack"
                    Do ' Wait For Player To hit a key
                        kbd& = _KeyHit
                        _Delay .05
                    Loop Until kbd& > 0

                    'Do: Key$ = InKey$: Loop Until Key$ = Chr$(32) ' Loop until Press Enter
                    Select Case kbd&
                        Case 97

                        Case 114 'r
                            Color 6: MessageHandler "You try to run"
                            Sleep 8
                            Chanceofescape = Int(Rnd * 2)
                            Select Case Chanceofescape
                                Case Is > 0
                                    MessageHandler "You Run And Escape The Monster"
                                    Sleep 8
                                    fight = FALSE
                                    enconter = FALSE
                                    current% = lastmade%
                                    GoTo escexit
                                Case Is < 1

                                    MessageHandler "your way is blocked"

                                    Sleep 8
                            End Select

                    End Select





                    Combat:
                    attack = Int(Rnd * 30)
                    AP% = 5
                    AP% = AP% + WeaponBonus% + AB%
                    'If keyed$ = "a" Then
                    Select Case attack

                        Case Is = MonsterAttack
                            MessageHandler "No one wins this round."
                            MessageHandler blank$
                        Case Is > MonsterAttack

                            Color 10
                            MessageHandler blank$
                            MessageHandler "You Attack and Hit " + MonsterTitle$ + "!!!!"
                            MessageHandler "With Your " + EqpWepon$
                            MonsterHealth% = MonsterHealth% - AP%
                            MessageHandler blank$
                            If MonsterHealth% < 5 Then
                                Color 20: MessageHandler MonsterTitle$ + " is Hurt Bad"
                                MessageHandler blank$
                                MessageHandler blank$
                            End If
                        Case Is < MonsterAttack
                            Color 20
                            MessageHandler blank$
                            wounded$ = " has hit You"
                            MessageHandler MonsterTitle$ + wounded$
                            Color 4

                            MessageHandler "You Have Lost " + Str$(MonsterHit%) + " Hit points"
                            Color 7
                            drawstats

                            MessageHandler blank$
                            Health% = Health% - MonsterHit%
                    End Select
                    'End If



                Loop

                If Health% > 0 Then
                    Color 20
                    MessageHandler "Monster is Dead"
                    MessageHandler blank$
                    Color 15
                    MessageHandler "You won the fight!"
                    MessageHandler blank$
                    F$ = "You get "
                    p$ = " pieces of gold!"
                    MonsterGold% = 3
                    Color 14
                    MessageHandler F$ + Str$(MonsterGold%) + p$
                    MessageHandler "You have Earned" + Str$(MonsterExp%) + " Experance Points"
                    Color 15
                    Chance1% = Int(Rnd * 10)

                    gold% = gold% + MonsterGold%
                    Experance% = Experance% + MonsterExp%
                    If Chance1% > 5 Then
                        MessageHandler "You Recive 1 Heal Potion"
                        HerbCount% = HerbCount% + 1

                    End If
                    enconter = FALSE
                    'Do: Key$ = InKey$: Loop Until Key$ = Chr$(32) ' Loop until Press Enter
                    monster(row, column) = 0
                    Sleep 6
                Else
                    MessageHandler MonsterTitle$ + " killed you!"
                    Cls
                    Color 15, 20
                    Locate 15, 15
                    Print "Game over!"; Space$(20)
                    Do: Key$ = InKey$: Loop Until Key$ = Chr$(32) ' Loop until Press Enter
                    End
                End If
                Cls
                current% = lastmade%
            End If

        Case 117 'u key

            If HerbCount% > 0 Then
                Health% = Health% + 30
                MessageHandler "You Recoverd 30 Hitpoints"
                If Health% > MaxHealth% Then
                    Health% = MaxHealth%
                End If
                HaveHerb = FALSE
                If HerbCount% >= 0 Then
                    HerbCount% = HerbCount% - 1
                End If
            Else HerbCount% = 0
                MessageHandler "You Have No Herb"
            End If
    End Select
    escexit:
    kbd& = 0
Loop Until exitflag%%

 
Function CreateRoom (Going%, From%, Direction%%)
    Maze(Going%).Walls.up = Int(Rnd * 2)
    Maze(Going%).Walls.down = Int(Rnd * 2)
    Maze(Going%).Walls.left = Int(Rnd * 2)
    Maze(Going%).Walls.right = Int(Rnd * 2)
    Maze(Going%).Created = TRUE
    'which direction did player head
    Select Case Direction%%
        Case UP 'player went up
            Maze(Going%).Walls.down = 1 'down has to be open, direction coming from
            Maze(Going%).South = From% 'south goes back to previous room
            Maze(From%).North = Going% 'the room id north of previous room
        Case DOWN
            Maze(Going%).Walls.up = 1 'up has to be open, direction coming from
            Maze(Going%).North = From% 'north goes back to previous room
            Maze(From%).South = Going% 'the room id south of previous room
        Case LEFT
            Maze(Going%).Walls.right = 1 'left has to be open, direction coming from
            Maze(Going%).East = From% 'east goes back to previous room
            Maze(From%).West = Going% 'the room id west of previous room
        Case RIGHT
            Maze(Going%).Walls.left = 1 'right has to be open, direction coming from
            Maze(Going%).West = From% 'west goes back to previous room
            Maze(From%).East = Going% 'the room id east of previous room
    End Select
End Function
Sub RandomEnconterGen (id%)
    'Random Enconter Generator


    Monstercount% = Int(Rnd * 10)
    If Monstercount% > 6 Then
        enconter = TRUE

        fight = TRUE


        RandomEnconter$ = "You have enconterd a "

        'MonsterName$ = MID$(monster$(monsterType), 1, 10)
        FightORrun$ = "Press F to Fight or any other key to run"

    Else
        fight = FALSE
        enconter = FALSE
        RandomEnconter$ = "                                      "
        MonsterName$ = "                                         "
        'MonsterName$ = MID$(monster$(monsterType), 1, 10)
        FightORrun$ = "                                          "



    End If



End Sub
Sub DescribeRoom (id%)
    If enconter = TRUE Then
        Select Case id%
            'If id% < 6 Then
            Case Is <= 6
                MonsterName$ = "Kobold"
                MonsterTilte$ = "Kobold"
                MonsterHealth% = 20
                MonsterGold = 3
                MonsterAttack = 5
                MonsterHit% = 2
                MonsterExp% = 2
            Case Is < 9 And id% > 6
                MonsterName$ = "King Kobold"
                MonsterTilte$ = "King Kobold"
                MonsterHealth% = 25
                MonsterGold = 6
                MonsterAttack = 5
                MonsterHit% = 4
                MonsterExp% = 2
            Case Is > 9 And id% < 15
                MonsterName$ = "Lizard Man"
                MonsterTitle$ = "Lizard Man"
                MonsterHealth% = 30
                MonsterGold = 12
                MonsterAttack = 5
                MonsterHit% = 6
                MonsterExp% = 2
            Case Is > 25
                MonsterName$ = "Zulu Warrior"
                MonsterTitle$ = "Zulu Warrior"
                MonsterHealth% = 45
                MonsterGold = 12
                MonsterAttack = 5
                MonsterHit% = 10
                MonsterExp% = 2
            Case Is = 50
                'If id% > 7 Then
                MonsterName$ = "Bunny"
                MonsterHealth% = 200
                MonsterAttack = 3
                MonsterHit% = 20
                MonsterGold = 500
        End Select

        'End If
    End If


    MessageHandler "You are currently in room" + Str$(id%)
    MessageHandler a$ + d$(UP) + b$ + c$(Maze(id%).Walls.up)
    MessageHandler a$ + d$(DOWN) + b$ + c$(Maze(id%).Walls.down)
    MessageHandler a$ + d$(LEFT) + b$ + c$(Maze(id%).Walls.left)
    MessageHandler a$ + d$(RIGHT) + b$ + c$(Maze(id%).Walls.right)
    MessageHandler blank$
    If id% = 0 Then
        MessageHandler blank$
        Color 3: MessageHandler "You Are at The Entrance of the Dungeon": Color 15
    End If
    If id% = 7 Then
        Trapchance% = Int(Rnd * 2)
        'If Trapchance% > 1 Then
        If trap = 1 Then
            MessageHandler "Spikes fly out of the wall and you loose 6 hit points"
            HitPoints% = HitPoints% - 6
            trap = 2
        End If
    End If
    'End If
    If id% > 0 And id% < 3 Then
        Color 7: MessageHandler "You Wonder Down A dimly corridor": Color 15
    End If
    If id% = 50 Then
        MessageHandler "You have Found the exit"
    End If
    If id% = 4 Then
        Color 2: MessageHandler "This Place Was once a Garden": Color 7
    End If
    If id% = 5 Then
        MessageHandler "This Was once A kitchen"
    End If
    MonsterTitle$ = MonsterName$
    MessageHandler blank$
    Color 4: MessageHandler RandomEnconter$ + MonsterTitle$ ' Red Mesage if you encounter monster
    MessageHandler FightORrun$: Color 15

End Sub



Sub ClearMaze
    For i% = 0 To 32000
        Maze(i%).North = -1
        Maze(i%).South = -1
        Maze(i%).West = -1
        Maze(i%).East = -1
        Maze(i%).Created = FALSE
    Next i%
End Sub
 
Sub dumpmap
    For i% = 0 To lastmade%
        Print #1, "room ID"; i%
        Print #1, "north leads to "; Maze(i%).North
        Print #1, "south leads to "; Maze(i%).South
        Print #1, "west leads to "; Maze(i%).West
        Print #1, "east leads to "; Maze(i%).East
        Print #1, "up wall status "; Maze(i%).Walls.up
        Print #1, "down wall status "; Maze(i%).Walls.down
        Print #1, "left wall status "; Maze(i%).Walls.left
        Print #1, "right wall status "; Maze(i%).Walls.right
        Print #1, "current"; current%
    Next i%
End Sub

Sub PlayerWeapon
    If Weapon$ = "knife" Then
        WeaponBonus% = 1
    End If
    If Weapon$ = "Sword" Then
        WeaponBonus% = 4
    End If
End Sub

Sub drawstats

    Class$ = "Fighter"
    Color 15
    Levelup
    Locate 2, 30: Print "Charcter Name: "; CharName$

    Locate 4, 30: Print "Lvl: "; Lvl%
    Locate 4, 50: Print "EXP: "; Experance%
    Locate 3, 30: Print "Race: "; Race$
    Locate 3, 50: Print "Class: "; Class$
    Locate 6, 30: Print "HP: "; Health%; " / "; MaxHealth%
    Locate 5, 30: Print "Gold: "; gold%
    Locate 8, 30: Print "Heal Potions: "; HerbCount%

    'LOCATE 16, 45: PRINT Monstercount% 'For Debuging Encounters Code
End Sub
Sub Levelup
    Lvlup = 0
    LVL2 = 10

    Select Case Experance%
        Case Is = 6
            Lvl% = 2
            MessageHandler "You Have Reached Experance Level 2"
            AB% = 1
            MaxHealth% = MaxHealth% + 5
            Lvlup = TRUE
            Experance% = Experance% + 2

        Case Is = 24
            Lvl% = 3
            MaxHealth% = MaxHealth% + 10
            AB% = 1
            Lvlup = TRUE
            Experance% = Experance% + 2
            MessageHandler "You Have Advanced to Experance Level 3"
        Case Is = 36
            Lvl% = 4
            AB% = 2
            MaxHealth% = MaxHealth% + 10
            Lvlup = TRUE
            Experance% = Experance + 2
            MessageHandler "You Have Advanced to Experance Level 4"
        Case Is = 72
            Lvl% = 5
            AB% = 3
            MaxHealth% = MaxHealth% + 20
            Lvlup = TRUE
            Experance% = Experance + 2
            MessageHandler "You Have Advanced to Experance Level 5"
        Case Is = 184
            Lvl% = 6
            AB% = 4
            MaxHealth% = MaxHealth% + 25
            Lvlup = TRUE
            Experance% = Experance + 2
            MessageHandler "You Have Advanced to Experance Level 6"
    End Select

End Sub

Sub drawroom (id%)

    If Maze(id%).Walls.up Then 'has passage
        Locate 1, 1: Print wall$(1)
    Else
        Locate 1, 1: Print wall$(0)
    End If
    For i%% = 2 To 11
        Locate i%%, 2: Print "º"
        Locate i%%, 21: Print "º"
    Next i%%
    If Maze(id%).Walls.left Then 'has passage
        Locate 5, 2: Print "¼": Locate 6, 2: Print " ": Locate 7, 2: Print "»"
    End If
    If Maze(id%).Walls.right Then 'has passage
        Locate 5, 21: Print "È": Locate 6, 21: Print " ": Locate 7, 21: Print "É"
    End If
    If Maze(id%).Walls.down Then 'has passage
        Locate 12, 1: Print wall$(3)
    Else
        Locate 12, 1: Print wall$(2)
    End If
End Sub
 
Sub makerooms
    'ÃšÃ„Â¿Â³Ã€Ã™
    wall$(0) = " ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ» "
    wall$(1) = " ÉÍÍÍÍÍÍÍ¼  ÈÍÍÍÍÍÍÍ» "
    wall$(2) = " ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ "
    wall$(3) = " ÈÍÍÍÍÍÍÍ»  ÉÍÍÍÍÍÍÍ¼ "
End Sub
 
Sub MessageHandler (txt$)
    'define message area
    View Print 13 To 25
    'display message
    Locate 25, 3: Print txt$
    'restore screen area
    View Print
    _Delay .25
End Sub



