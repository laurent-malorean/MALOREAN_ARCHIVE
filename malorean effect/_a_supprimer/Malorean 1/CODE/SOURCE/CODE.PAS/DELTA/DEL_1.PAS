USES CGraph,Crt,gest_dac;

CONST b =25;
VAR   V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
      VGA                  : TGRAPHVGA;
      Xe,Ye                : WORD;
      X                    : WORD;
      Y                    : WORD;
      COU                  : BYTE;
      T_Xe,T_Ye            : WORD;

BEGIN;
VGA.GraphMode;
put_dac(BLUE);
X:=0;
Y:=0;
For xe:=1 to 99 Do  Begin; T_Xe   :=T[Xe];
                           X:=X+(Xe DIV 10);
For Ye:=1 TO Xe DO Begin;
                           T_Ye   :=T[Ye];
                           Y:=Y+(Ye DIV 10);
                           COU:=ROUND(50*SQRT(X*X+Y*Y));
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