USES CGraph,Crt;

VAR  V                   : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     Ax                  : BYTE;
     Bx                  : ARRAY [0..319] Of BYTE;
     Cx                  : ARRAY [0..319] Of BYTE;
     Ay                  : BYTE;
     By                  : ARRAY [0..199] Of BYTE;
     Cy                  : ARRAY [0..199] Of BYTE;
     P2                  : ARRAY [0..199] Of BYTE;
     Xe,Ye               : BYTE;
     X                   : WORD;
     Xcarre              : BYTE;
     T_Xe,T_Ye           : WORD;
     F                   : WORD;
     P1                  : BYTE;
     VGA                 : TGraphVga;
     cou                 : BYTE;

BEGIN;
VGA.GraphMode;
LoadPal('e:\tp\pal\blue.pal');

Ax    :=1;   Bx[0] :=2;   Cx[0] :=3;
For F:=1 to 319 Do Begin; Bx[f]:=2*Ax+Bx[F-1]; Cx[f]:=Bx[F-1]+Cx[F-1]; END;

Ay    :=1;   By[0] :=3;   Cy[0] :=2;
For F:=1 to 199 Do Begin; By[f]:=2*Ay+By[F-1]; Cy[f]:=By[F-1]+Cy[F-1]; END;

For Ye:=0 TO 99 DO P2[Ye]:=ye*ye+By[Ye]*ye+Cy[Ye];

For x:=1 to 500 DO  Begin; Xcarre :=X*X;
For xe:=0 to 99 Do  Begin; P1     :=XCarre+Bx[Xe]*X+Cx[Xe];
                           T_Xe   :=T[Xe];
For Ye:=Xe TO 99 DO Begin; cou    :=p1 +  p2[Ye];
                           T_Ye   :=T[Ye];

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