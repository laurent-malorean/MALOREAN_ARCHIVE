USES GEST_GRAPH,gest_dac,CRT;

VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     X                    : WORD;
     Xe,Ye                : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;
     X1,Y1                : WORD;
     X2                   : ARRAY [0..99]       Of WORD;
     T_COU1               : ARRAY [0..99,0..99] OF WORD;
     T_COU2               : ARRAY [0..99,0..99] OF WORD;


BEGIN;
GraphMode;
put_dac(PAl4);

For Xe:=0 To 99 Do  X2[Xe]:=1 + ( ((300)*Xe) DIV 99 );

For xe:=0  TO 99 DO
For Ye:=xe TO 99 DO BEGIN;
                    T_COU1[Xe,Ye]:=2*(X2[Xe]+X2[Ye]);
                    T_COU2[Xe,Ye]:=((X2[Xe])*(X2[Xe]) + X2[Ye]*X2[Ye]);
                    END;

For X:=1   TO 500 DO
For xe:=0  TO 99  DO BEGIN; T_Xe :=Mul320[Xe];
For Ye:=Xe TO 99  DO BEGIN; T_Ye :=Mul320[Ye];
                            COU  :=(T_Cou1[Xe,Ye]*X) DIV T_COU2[Xe,Ye];
                            V  [ t_Ye +Xe] := Cou;
                            V  [ t_Xe +Ye] := Cou;
                            V  [-t_Ye +Xe] := Cou;
                            V  [-t_Xe +Ye] := Cou;
                            V  [-t_Ye -Xe] := Cou;
                            V  [-t_Xe -Ye] := Cou;
                            V  [ t_Ye -Xe] := Cou;
                            V  [ t_Xe -Ye] := Cou;
                     END;
                     END;
END.