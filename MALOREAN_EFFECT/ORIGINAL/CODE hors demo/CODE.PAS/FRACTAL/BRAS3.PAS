Program Mandel; {l21}

Uses CGraph,Crt,gest_dac;

const
xmax=319;
ymax=199;

Var Cga                    : TGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : word;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;

Begin; {1}

Amin:= 0.3400;
Amax:= 0.3773;
Bmin:= 0.0594;
Bmax:= 0.1050;
pasX:=(Amax-Amin)/xmax;
pasY:=(Bmax-Bmin)/ymax;
For xe:=0 to xmax do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to ymax do Py [ye]:=bmin+pasy*(ye+1);




For Xe:=0 to xmax Do
For Ye:=0 to ymax do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     nbiter:=0;
                     While       (nbiter<250)
                           and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=SQR(x)-y*y+Px[xe];
                                              Y:=2*X*Y   +Py[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}

Vga_Ecran[t[ye]+xe]:=Round(y*Nbiter);



                                        End;    {1.1.1}

End; {1}


BEGIN;

Cga.GraphMode;
put_dac(Blue);
Courbe;
Sauve_Shoot('e:\bit\bras1.bit');
delay(5000);
repeat;until keypressed;
END.





