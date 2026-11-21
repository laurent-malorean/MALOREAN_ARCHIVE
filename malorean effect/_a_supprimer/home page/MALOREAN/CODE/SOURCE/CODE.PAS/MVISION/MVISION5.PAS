 Program Mandel;

Uses CGraph,Crt,Math;

Var Cga                    : TGraphVga;

Procedure Courbe;
Var
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;

Xe,Ye : Word;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;
CosY                   : Array [0..199] Of Real;
SinX                   : Array [0..319] Of Real;

PartieA,PartieB        : Real;

Begin; {1}

Amin:= -8;
Amax:=  8;
Bmin:= -8;
Bmax:=  8;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 160 Do
For Ye:=0 to 100 do Begin;
                    PartieA:=Px[xe]*CosY[Ye];
                    PartieB:=Py[Ye]*SinX[Xe];
                    Vga_Ecran[t[ye]+xe]:=Round(PartieA+PartieB);
                    VGA_Ecran[T[Ye]+319-Xe]:=Round(-PartieA-PartieB);
                    VGA_Ecran[T[199-Ye]+Xe]:=Round(PartieA-PartieB);
                    VGA_Ecran[T[199-Ye]+319-Xe]:=Round(-PartieA+PartieB);
                    End;


End;


BEGIN;

Cga.GraphMode;
loadPal('e:\tp\pal\Pal1.pal');
Courbe;
END.





