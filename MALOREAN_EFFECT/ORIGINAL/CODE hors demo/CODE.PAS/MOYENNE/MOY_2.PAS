{Z1=SQRT(Z2)}
USES CGraph,Crt,gest_dac;

VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     VGA                  : TGRAPHVGA;
     Xe,Ye                : WORD;
     X                    : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;

BEGIN;
VGA.GraphMode;
put_dac(BLUE);


FOR X:=1 to 100 DO BEGIN;
For xe:=1 to 99 Do  Begin; T_Xe   :=T[Xe];
For Ye:=1 TO Xe DO Begin;
                           T_Ye   :=T[Ye];
                           COU:=ROUND( SQRT(SQRT(Xe*Xe+Ye*Ye)+Xe) );
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
                    END;

repeat;until keypressed;
END.