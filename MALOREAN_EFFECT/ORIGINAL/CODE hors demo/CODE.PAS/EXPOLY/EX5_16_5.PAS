USES CGraph,Crt,gest_dac;

Const Max=99;
      Max2=Max div 2;
VAR  Ax       : ARRAY [0..319] Of Word;
     Bx       : ARRAY [0..319] Of Word;
     Cx       : ARRAY [0..319] Of Word;
     Ay       : ARRAY [0..199] Of Word;
     By       : ARRAY [0..199] Of Word;
     Cy       : ARRAY [0..199] Of Word;
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     VGA      : TGraphVga;
     cou : word;
     ForPolyX,ForPolyY : Byte;

BEGIN;
VGA.GraphMode;
put_dac(blue);


Ax[0]:=0;
Bx[0]:=1;
Cx[0]:=0;
Ay[0]:=1;

For ForPolyX:=1 To 25 Do Begin;
                         Inc(Ay[0]);
                         Inc(Bx[0]);

For F:=1 to 319 Do Begin;
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 99 DO   Begin
                    Inc(x,2);
For xe:=0 to Max2 Do  Begin;
                    P1:=Bx[Xe]*x+Cx[Xe];
For Ye:=1 TO Xe DO Begin;
                    P2:=Ay[Ye]*ye*ye;{+By[Ye]*ye+Cy[Ye];}
                    cou:=p1 +  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;

                    Vga_Ecran[t[100+max-Xe]+max+160-Ye]:=Cou;
                    Vga_Ecran[t[100+max-Ye]+max+160-Xe]:=Cou;
                    Vga_Ecran[t[100+max-Ye]-max+160+Xe]:=Cou;
                    Vga_Ecran[t[100+max-Xe]-max+160+Ye]:=Cou;
                    Vga_Ecran[t[100-max+Xe]-max+160+Ye]:=Cou;
                    Vga_Ecran[t[100-max+Ye]-max+160+Xe]:=Cou;
                    Vga_Ecran[t[100-max+Ye]+max+160-Xe]:=Cou;
                    Vga_Ecran[t[100-max+Xe]+max+160-Ye]:=Cou;


                   end;
                   end;

For xe:=Max2 to Max Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=1 TO (Max-Xe) DO Begin;
                    P2:=Ay[Ye]*ye*ye;{+By[Ye]*ye+Cy[Ye];}
                    cou:=p1 +  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;

                    Vga_Ecran[t[100+max-Xe]+max+160-Ye]:=Cou;
                    Vga_Ecran[t[100+max-Ye]+max+160-Xe]:=Cou;
                    Vga_Ecran[t[100+max-Ye]-max+160+Xe]:=Cou;
                    Vga_Ecran[t[100+max-Xe]-max+160+Ye]:=Cou;
                    Vga_Ecran[t[100-max+Xe]-max+160+Ye]:=Cou;
                    Vga_Ecran[t[100-max+Ye]-max+160+Xe]:=Cou;
                    Vga_Ecran[t[100-max+Ye]+max+160-Xe]:=Cou;
                    Vga_Ecran[t[100-max+Xe]+max+160-Ye]:=Cou;


                   end;
                   end;

                   end;
                   end;

repeat; until keypressed;
END.