USES CGraph,Crt;

VAR  Ax       : ARRAY [0..319] Of Word;
     Bx       : ARRAY [0..319] Of Word;
     Cx       : ARRAY [0..319] Of Word;
     Ay       : ARRAY [0..199] Of Word;
     By       : ARRAY [0..199] Of Word;
     Cy       : ARRAY [0..199] Of Word;
     Az       : ARRAY [0..319] Of Word;
     Bz       : ARRAY [0..319] Of Word;
     Cz       : ARRAY [0..319] Of Word;
     Xe,Ye      : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     P3       : Word;
     VGA      : TGraphVga;
     cou : word;

BEGIN;
VGA.GraphMode;
LoadPal('e:\tp\pal\Blue.pal');
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

Az[0]:=1;
Bz[0]:=7;
Cz[0]:=4;
For Xe:=1 to 319 Do
For Ye:=1 to 199 do begin;

                   Az[Xe]:=2*Bx[Ye-1]+Cx[Xe];
                   Bz[Ye]:=Ax[Xe-1]-Bx[Ye];
                   Cz[Xe]:=(Az[Xe] mod 5) + 3*Bz[Xe];
                   END;



For x:=1 to 500 DO  Begin;
For xe:=0 to 99 Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO 99 DO Begin;
                    P2:=Ay[Ye]*ye*ye+By[Ye]*ye+Cy[Ye];
                    P3:=Az[Xe-Ye]*x+Bz[Ye]*x+Cz[Xe];

                    cou:=P3;
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
                   end;

repeat; until keypressed;
END.