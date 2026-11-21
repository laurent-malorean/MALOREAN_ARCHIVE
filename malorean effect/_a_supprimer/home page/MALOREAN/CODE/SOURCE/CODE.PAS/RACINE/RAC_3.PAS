{Z1=SQRT(Z2)}
USES GEST_GRAPH,Crt,GEST_DAC;

VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     Xe,Ye                : WORD;
     X                    : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;

BEGIN;
GraphMode;
PUT_DAC(BLUE);


For xe:=1 to 99 Do  Begin; T_Xe   :=Mul320[Xe];
For Ye:=1 TO Xe DO Begin;
                           T_Ye   :=Mul320[Ye];
                           COU:=ROUND( 20*SQRT(SQRT(Xe*Xe+Ye*Ye)-Xe)+20*SQRT(SQRT(Xe*Xe+Ye*Ye)+Xe) );
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