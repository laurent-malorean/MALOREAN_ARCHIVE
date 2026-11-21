Program Mandel;

Uses CGraph,Crt,gest_dac;



Var Cga                    : TGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : Byte;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;

color                  : byte;

Begin; {1}

Amin:= -2;
Amax:= +2;
Bmin:= -2;
Bmax:=  2;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/200;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);




For Xe:=0 to 320 Do
For Ye:=0 to 99 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<2) Do Begin
                                              Xp:=SQR(x)-y*y+Px[xe];
                                              Y:=2*X*Y   +Py[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=abs(x)+abs(y);
                                              End;

Vga_Ecran[t[ye]+xe]:=NbIter;
Vga_Ecran[t[199-ye]+xe]:=NbIter;
                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
put_dac(Pal1);
Courbe;
delay(5000);
END.





