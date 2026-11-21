Program Mandel;

Uses Crt,GEST_Graph;

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







Procedure Courbe;
Var
F1,F2        : Integer;
Begin; {1}

Amin:=-1.8141;
Amax:=-1.7244;
Bmin:=-0.0372;
Bmax:=0.0372;
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
                                        While (n<127) and (X*X+Y*Y<4) Do Begin {1.1.1.1}
                                                                         Xp:=X*X-Y*y+A;
                                                                         Y:=2*X*Y   +B;
                                                                         X:=Xp;
                                                                         N:=N+1;
{                                                                         module:=x*x+y*y;}
                                                                         End;   {1.1.1.1}
                                        Xpt:=     Round((a-amin)/pasx);
                                        Ypt:=Ymax-Round((B-Bmin)/pasy);
cou:=round(4*((n/256)-round(n/256)));
PutPixel(xpt,ypt,cou);

                      {                      If n<8    Then PutPixel(Xpt,Ypt,Black)
                                        Else If n<16   Then PutPixel(Xpt,Ypt,Lightgray)
                                        Else If n<32   Then PutPixel(Xpt,Ypt,Blue)
                                        Else If n<64   Then PutPixel(Xpt,Ypt,red)
                                        Else If n<128  Then PutPixel(Xpt,Ypt,black);}



                                        End;    {1.1.1}
                     End; {1.1}

End; {1}


BEGIN;
GraphMode;


Courbe;

Repeat;
until keypressed;
Nosound;
END.




