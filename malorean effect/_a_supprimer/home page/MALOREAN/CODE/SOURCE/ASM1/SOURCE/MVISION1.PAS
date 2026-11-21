{$L MVision1}

Program Mandel;

{$f+}
Procedure GraphMode4Plan; EXTERNAL ;
Procedure PutPixel4Plan (x4,y4,Couleur4,OfsVram4 : Word); EXTERNAL ;
Procedure LoadPal; EXTERNAL;
Procedure Scrool;  EXTERNAL;
{$f-}

Var f : word;

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
Py                     : Array [0..800] Of Real;
CosY                   : Array [0..800] Of Real;
SinX                   : Array [0..319] Of Real;

PartieA,PartieB        : Real;
f : word;
Begin; {1}

Amin:= -15;
Amax:=  15;
Bmin:= -30;
Bmax:=  30 ;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/800;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 800 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=25*(Sin(Px[Xe])+(cos(-Px[Xe])  ));
For ye:=0 to 800 do CosY [ye]:=25*(Cos(Py[Ye])+(sin(-PY[Ye]) ));


For Xe:=0 to 319 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    Putpixel4Plan(Xe,Ye,Cou,0);
                    End;
For Ye:=200 to 400 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    Putpixel4Plan(Xe,Ye-200,Cou,16000);
                    End;
For Ye:=400 to 600 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    Putpixel4Plan(Xe,Ye-400,Cou,32000);
                    End;
For Ye:=600 to 800 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    Putpixel4Plan(Xe,Ye-600,Cou,48000);
                    End;
                    end;


End;


BEGIN;

GraphMode4Plan;
LoadPal;
Courbe;
Scrool;
END.





