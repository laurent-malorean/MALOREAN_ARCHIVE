Uses CGraph,crt,GESt_DAC;

CONST

MUL=4000;
MUL2=MUL DIV 2;
C_X =319;
C_Y =199;
IterMax=50;

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

Amin:= Round( -0  *MUL    );
Amax:= Round(  0.5*MUL  );
Bmin:= Round( -0.8*MUL  );
Bmax:= Round(  0*MUL  );
pasX:=(Amax-Amin)/C_X;
pasY:=( (Bmax-Bmin)/C_Y);
For xe:=0 to C_X do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to C_Y do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));


For Ye:=0 to 199 Do
For Xe:=0 to C_X do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<IterMax)
                            and (Module<10000000) Do Begin
                                 Xp:=( (x*x-y*y)  div MUL ) +Px[Xe];
                                 Y:=( ((X*Y     ) DIV MUL2   )) +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)+ sqr(y);
                                 End;

If (NbIter=IterMAx) And (X<>0) Then Couleur:=Round(50*(X AND Y)/X)   Else Couleur:=7;
CGA.putpixel(Vga_Ecran,xe,ye,Couleur);

                                        End;
End;



BEGIN;
Cga.GraphMode;
PUT_DAC (Pal4);
Courbe;
Repeat;Until Keypressed;
END.





