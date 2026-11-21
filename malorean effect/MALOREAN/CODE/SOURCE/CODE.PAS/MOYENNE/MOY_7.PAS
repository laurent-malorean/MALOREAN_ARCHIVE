USES CGraph,Crt,gest_dac;

VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     VGA                  : TGRAPHVGA;
     Xe,Ye                : WORD;
     X                    : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;
     SOMME                : ARRAY[0..320] OF WORD;

BEGIN;
VGA.GraphMode;
put_dac(BLUE);

SOMME[0]:=0;
For Xe:=1 To 320 Do SOMME[Xe]:=SOMME[Xe-1]+Xe;

FOR X:=1 to 100 do
For xe:=1 to 99 Do  Begin; T_Xe   :=T[Xe];
For Ye:=Xe TO 99 DO Begin;
                           T_Ye   :=T[Ye];
                           COU:=(X)*SOMME[ABS(Xe-Ye)] DIV (SOMME[Xe]);
                           V  [ t_Ye +Xe] := Cou;
                           V  [ t_Xe +Ye] := Cou;
                           V  [-t_Ye +Xe] := Cou;
                           V  [-t_Xe +Ye] := Cou;
                           V  [-t_Ye -Xe] := Cou;
                           V  [-t_Xe -Ye] := Cou;
                           V  [ t_Ye -Xe] := Cou;
                           V  [ t_Xe -Ye] := Cou;

                    End;
                    End;

repeat;until keypressed;
END.