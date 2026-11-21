USES CGraph,Crt,gest_dac;

VAR  Ax       : ARRAY [0..319] Of Word;
     Bx       : ARRAY [0..319] Of Word;
     Cx       : ARRAY [0..319] Of Word;
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     VGA      : TGraphVga;
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

For x:=1 to 500 DO
For xe:=0 to 99 Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO 99 DO Begin;
                    P2:=Ax[Ye]*X*X+Bx[Ye]*X+Cx[Ye];
                    cou:=p1 -  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;

repeat; until keypressed;
END.