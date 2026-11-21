Program Mandel;

Uses CGraph,Crt,GESt_DAc;


Var Cga                    : TGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : Word;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;

Begin; {1}

Amin:= -1.3;
Amax:= 0.8;
Bmin:= -1.2;
Bmax:= 1.2 ;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/200;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);




For Xe:=0 to 319 Do
For Ye:=0 to 101 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While       (nbiter<2000)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=(x*x-y*y)*(x*x-y*y)-4*x*x*y*y+Px[xe];
                                              Y:=4*X*Y*(x*x-y*y)   +Py[ye];
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}
If Module<4 Then Vga_Ecran[t[ye]+xe]:=(Round(2000*x) AND Round(2000*y)) div 10;
If Module<4 Then Vga_Ecran[t[199-ye]+xe]:=(Round(2000*x) AND Round(2000*y)) div 10;

{CGA.putpixel(Vga_Ecran,xe,ye,NbIter);}

end;


End; {1}


BEGIN;
Cga.GraphMode;
PUT_DAc(PAL4);
Courbe;
delay(5000);
END.





