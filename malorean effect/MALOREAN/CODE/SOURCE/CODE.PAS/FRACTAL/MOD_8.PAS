Uses CGraph,crt;

CONST

MUL=256;
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

Amin:= Round( -1.5  *MUL    );
Amax:= Round(  0.5*MUL  );
Bmin:= Round( -1*MUL  );
Bmax:= Round(  1*MUL  );
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
                     While      (nbiter<25)
                            and (Module<10000000) Do Begin
                                 Xp:=( (x*x-y*y)  div MUL ) +Px[Xe];
                                 Y:=( ((X*Y     ) DIV MUL2   )) +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)+ sqr(y);
                                 End;

If (NbIter=25) And (Y<>0) Then Couleur:=((X MOD Y)*4)   Else Couleur:=7;
CGA.putpixel(Vga_Ecran,xe,ye,Couleur);

                                        End;
End;



BEGIN;
Cga.GraphMode;
{loadpal ('E:\tp\pal\Pal4.pal');}
Courbe;
Repeat;Until Keypressed;
END.





