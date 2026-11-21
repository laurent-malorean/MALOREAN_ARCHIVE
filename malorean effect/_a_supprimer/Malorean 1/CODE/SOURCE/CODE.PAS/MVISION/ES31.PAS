Program Mandel;

Uses CGraph,Crt,Math,gest_dac;

Var Cga                    : TGraphVga;
f : word;
pal : objPalette;

Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : Byte;

cou : byte;

pal : ObjPalette;
Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;
CosY                   : Array [0..199] Of Real;
SinX                   : Array [0..319] Of Real;

PartieA,PartieB        : Real;
f : word;
Begin; {1}

Amin:= -10;
Amax:=  10;
Bmin:= -10;
Bmax:=  10;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=40*Px[Xe]*Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=40*Py[Ye]*Cos(Py[Ye]);


For Xe:=0 to 320 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA)-round(PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;

                    End;
                    end;


End;


BEGIN;

Cga.GraphMode;
Put_DAC(blue);
Courbe;
Pal.GetDac(0,255,Pal.palette);
repeat; until keypressed;

for f:=1 to 5000 do Begin;
                    pal.Inc1Dac;
                    Delay(80);
                    end;

repeat; until keypressed;
END.





