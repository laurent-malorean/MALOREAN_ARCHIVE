Uses CGraph,crt,GESt_DAC;

CONST

MUL =128;
MUL2=MUL DIV 2;
C_X =319;
C_Y =199;


Var Cga         : tGraphVga;

Procedure Courbe;
Var


Xe,Ye                  : LongInt;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : Real;
module                 : LongInt;
NbIter                 : LongInt;

Px                     : Array [0..319] Of LongInt;
Py                     : Array [0..199] Of LongInt;
F : Integer;
couleur : byte;
Begin;

Amin:= Round( -3.0*MUL  );
Amax:= Round(  1.5*MUL  );
Bmin:= Round( -1.5*MUL  );
Bmax:= Round(  1.5*MUL  );

pasX:=(Amax-Amin)/C_X;
pasY:=(Bmax-Bmin)/C_Y;

For xe:=0 to C_X do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to C_Y do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));

For Ye:=0 to 099 Do
For Xe:=0 to 320  do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<1000) Do Begin
                                 Xp:=( ABS(X)-ABS(Y)   ) +Px[Xe];
                                 Y:=( (X+Y) ) +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=ABS(X)+ABS(Y);
                                 End;

Couleur:=NbIter;
CGA.putpixel(Vga_Ecran,xe,ye,Couleur);
CGA.putpixel(Vga_Ecran,xe,199-ye,Couleur);

                                        End;
End;



BEGIN;
Cga.GraphMode;
PUT_DAC(Pal4);
Courbe;
delay(5000);
END.





