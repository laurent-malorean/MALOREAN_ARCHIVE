Program Mandel;

Uses CGraph,Crt,Math,GEST_DAC;

Var Cga                    : TGraphVga;

Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : Byte;
cou : byte;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;
CosY                   : Array [0..199] Of Real;
SinX                   : Array [0..319] Of Real;

PartieA,PartieB        : Real;
 f : byte;

Begin; {1}

Amin:= -25;
Amax:=  25;
Bmin:= -25;
Bmax:=  25;

For f:=1 to 255 do begin;
amin:=Amin+0.3;
amax:=amax+0.3;

pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe])*Px[Xe];
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye])*Py[Ye];


{For Xe:=0 to 160 Do Begin;
                    PartieA:=Px[Xe]*SinX[Xe];
For Ye:=0 to 100 do Begin;
                    PartieB:=Py[Ye]*CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    Vga_Ecran[T[Ye]+319-Xe]:=Cou;
                    Cou:=Round(PartieA-PartieB);
                    VGA_Ecran[T[198-Ye]+Xe]:=Cou;
                    Vga_Ecran[T[198-Ye]+319-Xe]:=Cou;}


For Xe:=0 to 80 Do  Begin;
                    PartieA:=SinX[Xe];
For Ye:=Xe to 60 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA + PartieB);

                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;

                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;

                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;

                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                    End;
                    end;

End;

end;
BEGIN;

Cga.GraphMode;
PUT_DAC(pal1);
Courbe;
repeat; until keypressed;
END.





