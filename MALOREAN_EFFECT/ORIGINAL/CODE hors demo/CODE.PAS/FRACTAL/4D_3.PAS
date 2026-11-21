Program Mandel;

Uses CGraph,Crt;

Var Cga                    : TGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
Xmin,Xmax,Ymin,Ymax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : Byte;

Pa                     : Array [0..319] Of Real;
Pb                     : Array [0..199] Of Real;

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
For xe:=0 to 319 do Pa [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Pb [ye]:=bmin+pasy*(ye+1);

Xmin:=-2;
Xmax:= 2;
Ymin:=-2;
Ymax:= 1.9;

pasX:=(Xmax-Xmin)/320;
pasY:=(Ymax-Ymin)/200;
For xe:=0 to 319 do Px [xe]:=Xmin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=Ymin+pasy*(ye+1);



For Xe:=0 to 319 Do
For Ye:=0 to 199 do Begin; {1.1.1}
                     X:=Px[ye];
                     Y:=Py[ye];
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<25)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=SQR(x)-y*y+Pa[xe];
                                              Y:=2*X*Y   +Pb[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}


Vga_Ecran[t[ye]+xe]:=round(y+x);;
                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
Courbe;
delay(5000);
END.





