USES GEST_GRAPH,GEST_DAC,Crt;

VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     X                    : WORD;
     Xe,Ye                : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;
     A1,A2,B1,B2          : BYTE;
     dX1,fX1,dY1,fY1      : WORD;
     dX2,fX2,dY2,fY2      : WORD;
     X1,Y1,X2,Y2          : ARRAY[0..99] Of WORD;
     T_COU1               : ARRAY[0..99,0..99] OF WORD;
     T_COU2               : ARRAY[0..99,0..99] OF WORD;


BEGIN;
GraphMode;
PUT_DAC(PAL4);

A1:=1;   B1:=0;   A2:=1;   B2:=0;

dX1:=1;  fX1:=1;  dY1:=2;  fY1:=2;
dX2:=1;  fX2:=300;  dY2:=1;  fY2:=300;

For Xe:=0 To 99 Do  BEGIN;
                    X1[Xe]:=dX1 + ( ((fX1-dX1)*Xe) DIV 99 );
                    Y1[Xe]:=dY1 + ( ((fY1-dY1)*Xe) DIV 99 );
                    X2[Xe]:=dX2 + ( ((fX2-dX2)*Xe) DIV 99 );
                    Y2[Xe]:=dY2 + ( ((fY2-dY2)*Xe) DIV 99 );
                    END;
For xe:=0  TO 99 DO
For Ye:=xe TO 99 DO BEGIN;
T_COU1[Xe,Ye]:=(A1*X1[Xe]+Y1[Ye]+B1)*(A2*X2[Xe]+Y2[Ye]+B2);
T_COU2[Xe,Ye]:=( (A2*X2[Xe]+B2)*(A2*X2[Xe]+B2) + Y2[Ye]*Y2[Ye]);
                     END;

For x:=1 to 500 DO  Begin;
For xe:=0 to 99 Do  Begin; T_Xe   :=MUL320[Xe];
For Ye:=Xe TO 99 DO Begin;
                           T_Ye   :=MUL320[Ye];
                           COU:=(T_Cou1[Xe,Ye]*X) DIV T_COU2[Xe,Ye];
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
                    End;

END.