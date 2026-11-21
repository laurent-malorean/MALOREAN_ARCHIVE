Program Mandel;

Uses CGraph,Crt;



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

Amin:= -1.671875;
Amax:= -1.5546875;
Bmin:= -0.007;
Bmax:= 0.007;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/200;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);




For Xe:=0 to 320 Do
For Ye:=0 to 200 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     ASM
                     MOV AL,0;
                     MOV NbIter,AL;
                     END;
                     While      (nbiter<250)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=SQR(x)-x*y+Px[xe];
                                              Y:=2*X*Y   +Py[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}

{CGA.putpixel(Vga_Ecran,xe,ye,NbIter);}
If nbiter < 2   then color:=0 else
If nbiter < 4   then color:=1 else
If nbiter < 8   then color:=2 else
If nbiter < 16  then color:=3 else
If nbiter < 32  then color:=4 else
If nbiter < 64  then color:=5 else
If nbiter < 128 then color:=6 else
If nbiter < 256 then color:=7 ;


Vga_Ecran[t[ye]+xe]:=color;

                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
Courbe;
delay(5000);
END.





