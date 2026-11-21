Program Mandel;

Uses CGraph,crt;


Var Cga         : tGraphVga;

Const
c1=1024;
c2=512;

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

Amin:= Round( -2*C1    );
Amax:= Round(  0.5*C1  );
Bmin:= Round( -1.2*C1  );
Bmax:= Round(  1.2*C1  );
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));


For Ye:=0 to 100 Do
For Xe:=1 to 319 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<16777216) Do Begin
                                 Xp:=(x*x-y*y)  div C1      +Px[Xe];
                                 Y:=(x*y ) DIV 1024    +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)+(Sqr(y));
                                 End;

Couleur:=Nbiter;
Vga_Ecran[t[ye]+xe]:=Couleur;
Vga_Ecran[t[199-ye]+xe]:=Couleur;
                                        End;

End;



BEGIN;
Cga.GraphMode;
Courbe;
delay(5000);
END.





