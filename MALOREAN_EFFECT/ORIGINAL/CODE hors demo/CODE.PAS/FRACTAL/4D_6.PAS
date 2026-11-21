Program Mandel;

Uses CGraph,Crt;

Var Cga                    : TGraphVga;
NbIter                 : Byte;

Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
Xmin,Xmax,Ymin,Ymax    : Real;
pasX,pasY              : Real;
module                 : real;


Pa                     : Array [0..319] Of Real;
Pb                     : Array [0..199] Of Real;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;

color                  : byte;

Begin; {1}

Amin:= -2;
Amax:= -1;
Bmin:= -2;
Bmax:=  2 ;

pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/200;
For xe:=0 to 319 do Pa [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Pb [ye]:=bmin+pasy*(ye+1);

Ymin:=-0.8;
Ymax:= 0.8;

pasY:=(Ymax-Ymin)/200;
For ye:=0 to 199 do Py [ye]:=Ymin+pasy*(ye+1);



For Xe:=0 to 319 Do
For Ye:=0 to 100 do Begin; {1.1.1}
                     X:=0;
                     Y:=py[Ye];
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=SQR(x)+y*y+Pa[xe];
                                              Y:=2*X*Y  +Pb[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}


Vga_Ecran[t[ye]+xe]:=nbiter;
Vga_Ecran[t[199-ye]+xe]:=NbIter;

                                 End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
Courbe;
delay(5000);
END.





