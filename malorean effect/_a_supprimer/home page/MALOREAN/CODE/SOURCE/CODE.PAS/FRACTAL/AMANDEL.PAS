Program Mandel;

Uses CGraph;

Type
Im_a  = Array[0..319,0..199] Of byte;

Const
Xmax=320;
Ymax=200;
var    e,f : word;
Vga : TGRAphVga;





Procedure Courbe;
Var
Xe,Ye        : Integer;
xcarre : real;
a,b                    : Real;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;

module : real;
NbIter                 : Word;
Xpt,Ypt                : Integer;
c                      : word;

Begin; {1}

Amin:= -2;
Amax:= 1;
Bmin:= -1.2;
Bmax:= 1.2;
pasX:=(Amax-Amin)/Xmax;
pasY:=(Bmax-Bmin)/Ymax;


A:=Amin;
For Xe:=1 to Xmax Do Begin; {1.1}
                     A:=A+pasX;
                     B:=Bmin;
                     For Ye:=1 to Ymax do Begin; {1.1.1}
                                        B:=B+pasY;
                                        X:=0;
                                        Y:=0;
                                        NbIter:=0;
                                        module:=0;
                                        While (nbiter<50) and (Module<4) Do Begin {1.1.1.1}
                                                            Xp:=SQR(x)-SQR(Y)+A;
                                                            Y:=2*X*Y   +B;
                                                            X:=Xp;
                                                            NbIter:=NbIter+1;
                                                            module:=SQR(x)+SQR(y);
                                                                         End;   {1.1.1.1}

c:=Nbiter Mod 4;
Vga_ecran[t[ye]+xe]:=c;



{putpixel(xe+60,ye,blue);}
{If module<=4 then   Begin;
                    c:=round(50*module) mod 4;
                    Putpixel(60+Xe,Ye,c);
                    Ima^[xe+60,ye]:=c;
                    End;}

{If module<=4 then  Putpixel(Xe,Ye,7);}

{If NBITER <8    then c:=1 else
If nBITER <16   then c:=1 else
If nBITER <32   then c:=2 else
If nBITER <648  then c:=3 Else
If nBITER <=128  then c:=0 ;

putpixel(xe,ye,c);}






                                        End;    {1.1.1}
                     End; {1.1}

End; {1}


BEGIN;
Vga.GraphMode;;
Courbe;
END.




