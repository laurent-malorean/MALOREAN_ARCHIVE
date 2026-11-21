USES CGraph,Crt,gest_dac;

VAR  V         : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;
     Ax        : ARRAY [0..319] Of Word;
     Bx        : ARRAY [0..319] Of Word;
     Cx        : ARRAY [0..319] Of Word;
     Xe,Ye     : WORD;
     X         : Word;
     Xcarre    : Word;
     T_Xe,T_Ye : WORD;
     F         : WORD;
     P1,P2     : Word;
     VGA       : TGraphVga;
     cou : word;

BEGIN;
VGA.GraphMode;
put_dac(blue);
Ax[0]:=1;
Bx[0]:=0;
Cx[0]:=0;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;

For x:=1 to 260 DO  Begin;
                    Xcarre:=X*X;
For xe:=0 to 99 Do  Begin;
                    P1:=Xcarre+Bx[Xe]*X+Cx[Xe];
                    T_Xe:=T[Xe];
For Ye:=Xe TO 99 DO Begin;
                    P2:=Xcarre+Bx[Ye]*X+Cx[Ye];
                    If P2<>0 Then cou:=(90000*P1 Div  p2);
                    T_Ye:=T[Ye];
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