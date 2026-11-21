Program Mandel;

Uses CGraph,Crt,Math,gest_dac;

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

Begin; {1}

Amin:= -30;
Amax:=  30;
Bmin:= -7;
Bmax:=  7;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 319 Do
For Ye:=0 to 199 do Begin;
                    Cou:=Round( exp(Px[Xe]/7) *Py[Ye] + CosY[Ye] *Px[Xe] );
                    VGA_Ecran[T[Ye]+Xe]:=Cou
                    End;


End;


BEGIN;

Cga.GraphMode;
put_dac(pal1);
Courbe;
repeat; until keypressed;
END.





