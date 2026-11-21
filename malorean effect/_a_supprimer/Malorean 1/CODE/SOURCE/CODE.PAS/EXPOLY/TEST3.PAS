USES CGraph,Crt;

VAR  V                   : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;
     Ax                  : Word;
     Bx                  : ARRAY [0..319] Of Word;
     Cx                  : ARRAY [0..319] Of Word;
     Ay                  : Word;
     By                  : ARRAY [0..199] Of Word;
     Cy                  : ARRAY [0..199] Of Word;
     P2                  : ARRAY [0..199] Of Word;
     Xe,Ye               : WORD;
     X                   : Word;
     Xcarre              : Word;
     T_Xe,T_Ye           : WORD;
     F                   : WORD;
     P1                  : Word;
     VGA                 : TGraphVga;
     cou                 : Byte;
     Ofs1,Ofs2,Ofs3,Ofs4 : Integer;

BEGIN;
VGA.GraphMode;
LoadPal('e:\tp\pal\blue.pal');
Ax    :=1;
Bx[0] :=2;
Cx[0] :=3;
For F:=1 to 319 Do Begin;
                   Bx[f]:=2*Ax+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay    :=1;
By[0] :=3;
Cy[0] :=2;
For F:=1 to 199 Do Begin;
                   By[f]:=2*Ay+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;
For Ye:=0 TO 99 DO P2[Ye]:=ye*ye+By[Ye]*ye+Cy[Ye];


For x:=1 to 500 DO  Begin;
                    Xcarre:=X*X;
For xe:=0 to 99 Do  Begin;
                    P1:=XCarre+Bx[Xe]*X+Cx[Xe];
                    T_Xe:=T[Xe];
                    Ofs1:=-T_Xe+Xe;
                    Ofs2:=+T_Xe+Xe;
                    Ofs3:=-T_Xe-Xe;
                    Ofs4:=+T_Xe-Xe;
For Ye:=Xe TO 99 DO Begin;
                    cou:=p1 +  p2[Ye];
                    T_Ye:=T[Ye];
                    V  [ t_Ye +Xe] := Cou;
                    V  [-t_Ye +Xe] := Cou;
                    V  [-t_Ye -Xe] := Cou;
                    V  [ t_Ye -Xe] := Cou;
{                   V  [Ofs2] := Cou;
                    V  [Ofs1] := Cou;
                    V  [Ofs3] := Cou;
                    V  [Ofs4] := Cou;}
                    ASM;
                    MOV CL,Cou;
                    MOV AX,$0A000;
                    MOV ES,AX;

                    MOV BX,Ofs1;
                    ADD BX,32160
                    MOV ES:[BX],Cl;

                    MOV BX,Ofs2;
                    ADD BX,32160
                    MOV ES:[BX],Cl;

                    MOV BX,Ofs3;
                    ADD BX,32160
                    MOV ES:[BX],Cl;

                    MOV BX,Ofs4;
                    ADD BX,32160
                    MOV ES:[BX],Cl;

                    INC Ofs1;
                    INC Ofs2;
                    DEC Ofs3;
                    DEC Ofs4;
                    end;

                    End;
                    end;
                    end;

END.