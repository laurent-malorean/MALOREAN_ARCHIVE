Program Mandel; {l21}

Uses GEST_Graph,Crt;

const xmax=319;
      ymax=199;



Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
Mod_c                  : real;
NbIter                 : word;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;

Begin; {1}

Amin:= 0.3464;
Amax:= 0.3773;
Bmin:= 0.0594;
Bmax:= 0.0994 ;

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
                     Y :=Py[ye];
                     X :=Px[xe];
                     module:=SQR(x)+SQR(y);
                     mod_c :=SQR(x)+SQR(y);

                     While       (nbiter<25)
                           and (Module<4) Do Begin {1.1.1.1}
                                              module:=Sqrt(Module*(1-2*Px[xe])+Mod_c);
                                              Inc(nbiter);
                                              End;   {1.1.1.1}

Vga[MUL320[ye]+xe]:=nbiter mod 16;



                                        End;    {1.1.1}

End; {1}


BEGIN;

GraphMode;
{Loadpal('c:\tp\pal\blue.pal');}
Courbe;
{Sauve_Shoot('c:\tp\bit\bras2.bit');}
delay(5000);
repeat;until keypressed;
END.





