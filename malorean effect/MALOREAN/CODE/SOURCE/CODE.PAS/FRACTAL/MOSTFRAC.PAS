
Uses CGraph,Crt,gest_dac;


TYPE
TYP       =ARRAY [-1..6000] Of LongInt;

Var Cga                    : tGraphVga;


Procedure Courbe1;
Var
Xe,Ye                  : LongInt;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : Real;
module                 : LongInt;
NbIter                 : LongInt;

Px                     : Array [0..128] Of LongInt;
Py                     : Array [0..40] Of LongInt;
F : Integer;
couleur : byte;
Lo                          : ARRAY [0..32000] Of Integer;
EXPt                         : ^typ;
Begin; {1}

For module:=1 to 32000 do lo[module]:=Round(500*ln(module));
lo[0]:=-1;
new(expt);
expt^[-1]:=0;



Amin:= Round( -2*2000  );
Amax:= Round( 0.5*2000  );
Bmin:= Round( -1.2*2000);
Bmax:= Round( 1.2*2000);

pasX:=(Amax-Amin)/128;
pasY:=( (Bmax-Bmin)/79);
For xe:=0 to 128 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 40 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Xe:=0 to 128 Do
For Ye:=0 to 40 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<35)
                            and (Module<16000000) Do Begin
                                 Xp:=( (x*x -SQR(Y))  div 2000 )+Px[Xe];
                                 Y:=( (X*Y    ) DIV 1000 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+sqr(y);
                                 End;

couleur:=   NbIter And 255;
CGA.putpixel(Vga_Ecran,xe+80,140-ye,Couleur);
CGA.putpixel(Vga_Ecran,xe+80,60+ye,Couleur);
                                        End;









End; {1}


BEGIN;
Cga.GraphMode;
Courbe1;
END.





