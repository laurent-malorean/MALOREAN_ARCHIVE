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

Begin; {1}

Amin:= -18;
Amax:=  18;
Bmin:= -18;
Bmax:=  18;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);

For Xe:=0 to 319 Do
For Ye:=0 to 199 do Begin; {1.1.1}

Cou:=Round(Px[xe]*Cos(Py[Ye]-Px[Xe])+Py[Ye]*Sin(Px[Xe]+Py[Ye]));
Vga_Ecran[t[ye]+xe]:=Cou;

                    End;    {1.1.1}

End; {1}


BEGIN;

Cga.GraphMode;
PUT_DAC(pal1);
Courbe;
END.





