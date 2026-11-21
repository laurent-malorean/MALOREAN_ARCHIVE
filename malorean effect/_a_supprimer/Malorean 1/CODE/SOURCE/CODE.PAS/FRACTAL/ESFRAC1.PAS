Program Mandel;

Uses CGraph,crt;

CONST

MUL=256;
MUL2=MUL DIV 2;


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

Amin:= Round( -2  *MUL    );
Amax:= Round(  0.5*MUL  );
Bmin:= Round( -1.2*MUL  );
Bmax:= Round(  1.2*MUL  );
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));


For Ye:=0 to 100 Do
For Xe:=0 to 320 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<1677726) Do Begin
                                 Xp:=( (x*x-y*y)  div MUL )     +Px[Xe];
                                 Y:=( ((X*Y     ) DIV MUL2   ))  +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)-( sqr(y) shl 4);
                                 End;

If module>16777216 then couleur:=Nbiter And 255 ;
If (module<16777216) and (y<>0) then couleur:=x mod y;

CGA.putpixel(Vga_Ecran,xe,ye,Couleur);
CGA.putpixel(Vga_Ecran,xe,199-ye,Couleur);



                                        End;

End;



BEGIN;
Cga.GraphMode;
loadpal ('E:\tp\pal\volcano.pal');

Courbe;
END.





