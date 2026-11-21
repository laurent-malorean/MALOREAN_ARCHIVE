Program Mandel;

Uses CGraph,Crt,GEST_DAC;


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

Begin; {1}

Amin:= -2;
Amax:= 0.5;
Bmin:= -1.2;
Bmax:= 1.2 ;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/200;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);




For Xe:=0 to 320 Do
For Ye:=0 to 199 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     ASM
                     MOV AL,0;
                     MOV NbIter,AL;
                     END;
                     While       (nbiter<200)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=SQR(x)-y*y+Px[xe];
                                              Y:=2*X*Y   +Py[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}

Vga_Ecran[t[ye]+xe]:=round(y*nbiter);
{Vga_Ecran[t[199-ye]+xe]:=round(module*10)+nbiter;}

{CGA.putpixel(Vga_Ecran,xe,ye,NbIter);}



                                        End;    {1.1.1}

End; {1}


BEGIN;

Cga.GraphMode;
PUT_DAC(BLUE);
Courbe;
delay(5000);
END.





