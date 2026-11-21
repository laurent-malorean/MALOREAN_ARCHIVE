Program Mandel;

Uses CGraph,crt;

CONST

MUL=2048;
MUL2=MUL DIV 2;


Var Cga         : tGraphVga;


Procedure Courbe;
Var

Xe,Ye                  : LongInt;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : Real;
module                 : LongInt;
modmax                 : Longint;
NbIter                 : LongInt;


Px                     : Array [0..319] Of LongInt;
Py                     : Array [0..199] Of LongInt;
F : Integer;
couleur : byte;
Begin;

Amin:= Round( 0  *MUL    );
Amax:= Round(  0.17*MUL  );
Bmin:= Round( 0*MUL  );
Bmax:= Round(  0.115*MUL  );
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));

modmax:=mul*mul div 10;

For Ye:=0 to 199 Do
For Xe:=0 to 320 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<5)
                            and (Module<(ModMax)) Do Begin
                                 Xp:=( (x*x-y*y)  and 16711680 )     +Px[Xe];
                                 Y:=( ((X*Y     ) DIV MUL2   ))  +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)-( sqr(y) shl 4);
                                 End;

If module>16777216 then couleur:=Nbiter And 255 ;
If (module<16777216) and (y<>0) then couleur:=x mod y;
CGA.putpixel(Vga_Ecran,xe,ye,Couleur);



                                        End;

End;



BEGIN;
Cga.GraphMode;
loadpal ('E:\tp\pal\pal4.pal');
Courbe;
delay(5000);
END.





