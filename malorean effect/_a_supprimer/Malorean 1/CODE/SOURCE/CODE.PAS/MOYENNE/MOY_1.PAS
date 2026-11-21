USES CGraph,Crt,GEST_dac;

VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:0;
     VGA                  : TGRAPHVGA;
     Xe,Ye                : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;
     SOMME                : ARRAY[0..320] OF WORD;

BEGIN;
VGA.GraphMode;
put_dac(BLUE);

SOMME[0]:=0;
For Xe:=1 To 320 Do SOMME[Xe]:=SOMME[Xe-1]+Xe;

For xe:=0 to 320 Do  Begin; T_Xe   :=T[Xe];
For Ye:=0 TO 199 DO Begin;
                           T_Ye   :=T[Ye];
                           COU:=SOMME[Xe]+SOMME[Ye];
                           V  [ t_Ye +Xe] := Cou;
                    End;
                    End;

repeat;until keypressed;
END.