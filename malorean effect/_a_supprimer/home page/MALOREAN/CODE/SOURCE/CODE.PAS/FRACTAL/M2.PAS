Program Mandel;

Uses CGraph;



Var Cga                    : TGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Longint;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : Byte;

Px                     : Array [0..319] Of ShortInt;
Py                     : Array [0..199] Of ShortInt;

Begin; {1}

Amin:= -0.4;
Amax:= 0.4;
Bmin:= -0.4;
Bmax:= 0.4;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/200;
For xe:=0 to 319 do Px [xe]:=Round((amin+pasx*(xe+1))*60);
For ye:=0 to 199 do Py [ye]:=Round((bmin+pasy*(ye+1))*60);



For Xe:=0 to 320 Do
For Ye:=0 to 200 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     ASM
                     MOV AL,0;
                     MOV NbIter,AL;
                     END;
                     While      (nbiter<200)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=(SQR(x)-SQR(Y)) div 60 +Px[xe];
                                              Y:=2*X*Y div 60  +Py[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=(SQR(x)+SQR(y)) div 60;
                                              End;   {1.1.1.1}

CGA.putpixel(Vga_Ecran,xe,ye,NbIter AND 3);



                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
Courbe;
END.





