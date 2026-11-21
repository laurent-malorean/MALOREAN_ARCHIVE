Program Mandel;

Uses CGraph,Crt;

Const
xc=160;
yc=100;

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
Amax:=  0.5;
Bmin:= -1.2;
Bmax:=  1.2;
pasX:=(Amax-Amin)/Xc;
pasY:=(Bmax-Bmin)/Yc;
For xe:=0 to xc do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to yc do Py [ye]:=bmin+pasy*(ye+1);




For Xe:=0 to xc Do
For Ye:=0 to yc shr 1 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     ASM
                     MOV AL,0;
                     MOV NbIter,AL;
                     END;
                     While      (nbiter<40)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=SQR(x)-Y*y+Px[xe];
                                              Y:=2*X*y   +Py[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)*SQR(y);
                                              End;   {1.1.1.1}

CGA.putpixel(Vga_Ecran,xe,ye,NbIter);
CGA.putpixel(Vga_Ecran,xe,Yc-ye,NbIter);



                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
Courbe;
delay(5000);
END.





