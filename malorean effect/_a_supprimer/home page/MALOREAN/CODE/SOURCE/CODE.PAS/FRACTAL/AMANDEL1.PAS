Program Mandel;

Uses Crt,Graph;

Const
Xmax=319;
Ymax=200;

Var

a,b                    : Real;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;

module : real;
N                      : Integer;
Xpt,Ypt                : Integer;
cou : integer;

Procedure sond;
Begin;
Sound(400);
Delay(50);
Nosound;
End;




Procedure init_graph;
Var
Pilote,Mode            : Integer;
Begin;
Pilote:=Detect;
InitGraph (Pilote,Mode,'C:\turbo');
ClearDevice;
SetGraphMode (3);
End;

Procedure Close_Graph;
Begin;
CloseGraph;
End;



Procedure Courbe;
Var
F1,F2        : Integer;
Begin; {1}

Amin:=+0.3464;
Amax:=+0.3773;
Bmin:=+0.0594;
Bmax:=+0.0994;
pasX:=(Amax-Amin)/Xmax;
pasY:=(Bmax-Bmin)/Ymax;
A:=Amin;

For f1:=1 to Xmax Do Begin; {1.1}
                  A:=A+pasX;
                  B:=Bmin-PasY;
                  For f2:=1 to Ymax do Begin; {1.1.1}
                                    B:=B+pasY;
                                    X:=0;
                                    Y:=0;
                                    N:=0;
                             While (n<1500) and (X*X+Y*Y<4) Do Begin {1.1.1.1}
                                                               Xp:=X*X-Y*Y+A;
                                                               Y:=2*X*Y   +B;
                                                               X:=Xp;
                                                               N:=N+1;
                                                               module:=x*x+y*y;
                                                               End;   {1.1.1.1}
              Xpt:=     Round((a-amin)/pasx);
              Ypt:=Ymax-Round((B-Bmin)/pasy);


cou:=round(4*((module/4)-round(module/4)));
Putpixel(xpt,ypt,cou);


                                        End;    {1.1.1}
                     End; {1.1}

End; {1}


BEGIN;
Init_Graph;

Setbkcolor(White);

Courbe;
Sound(400);

Repeat;
until keypressed;
Nosound;
Close_Graph;
END.




{ If (Module<1) and (module>0) then  Putpixel(Xpt,Ypt,black);
 If (Module<2) and (module>1) then  Putpixel(Xpt,Ypt,lightgray);
 If (Module<3) and (module>2) then  Putpixel(Xpt,Ypt,blue);
 If (Module<4) and (module>3) then  Putpixel(Xpt,Ypt,red);
If module>5 then putpixel(xpt,ypt,black);}