USES CGraph,Crt;

VAR  V                   : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     VGA                 : TGRAPHVGA;
     X                   : WORD;
     Xe,Ye               : WORD;
     COU                 : BYTE;
     T_Xe,T_Ye           : WORD;
     A1,A2,B1,B2,C1,C2   : BYTE;
     dX1,fX1,dY1,fY1     : WORD;
     dX2,fX2,dY2,fY2     : WORD;
     X1,Y1,X2,Y2         : ARRAY[0..99] Of WORD;
     T_COU1               : ARRAY[0..99,0..99] OF WORD;
     T_COU2               : ARRAY[0..99,0..99] OF WORD;


BEGIN;
VGA.GraphMode;
LoadPal('e:\tp\pal\PAL4.pal');

dX1:=1;
fX1:=300;
dY1:=2;
fY1:=2;
dX2:=1;
fX2:=300;
dY2:=1;
fY2:=1;

For Xe:=0 To 99 Do  BEGIN;
                    X1[Xe]:=dX1 + ( ((fX1-dX1)*Xe) DIV 99 );
                    Y1[Xe]:=dY1 + ( ((fY1-dY1)*Xe) DIV 99 );
                    X2[Xe]:=dX2 + ( ((fX2-dX2)*Xe) DIV 99 );
                    Y2[Xe]:=dY2 + ( ((fY2-dY2)*Xe) DIV 99 );
                    END;
For xe:=0 to 99 Do begin;
For Ye:=xe TO 99 DO begin;
T_COU1[Xe,Ye]:=(X1[Xe]+Y1[Ye])*(X2[Xe]+Y2[Ye]);
T_COU2[Xe,Ye]:=(X2[Xe]*X2[Xe]+Y2[Ye]*Y2[Ye]);
                         end;end;
xe:=0;ye:=0;
For x:=1 to 500 DO  Begin;
For xe:=0 to 99 Do  Begin; T_Xe   :=T[Xe];
For Ye:=Xe TO 99 DO Begin;
                           T_Ye   :=T[Ye];
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