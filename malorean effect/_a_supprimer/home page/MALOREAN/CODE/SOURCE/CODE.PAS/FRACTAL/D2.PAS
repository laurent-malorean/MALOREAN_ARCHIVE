Program Mandel;

Uses CGraph,Printer,GEST_DAC;

type t=Array [-8000..8000] Of LongInt;

Var Cga                    : TGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : LongInt;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : Real;
module                 : LongInt;
NbIter                 : LongInt;
Xcarre                 : LongInt;

Px                     : Array [0..319] Of LongInt;
Py                     : Array [0..199] Of LongInt;
F : Integer;
couleur : byte;
Begin; {1}

Amin:= Round( -2*2048  );
Amax:= Round(  0.5*2048  );
Bmin:= Round( -1.2*2048);
Bmax:= Round(  1.2*2048);
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Xe:=0 to 320 Do
For Ye:=0 to 100 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                 Xcarre:=X*X;
                                 Xp:=( (Xcarre-y*y)  DIV 2048 )+Px[Xe];
                                 Y:=( (X*Y    ) DIV 1024 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=Xcarre+sqr(y);
                                 End;   {1.1.1.1}

{If (NbIter<50) And (x<>0) Then Couleur:= NbIter*y div x
             Else Couleur:= 0;{Round(Module/10000);}
If  (x<>0) Then Couleur:= NbIter*y div x;

CGA.putpixel(Vga_Ecran,xe,ye,Couleur);
CGA.putpixel(Vga_Ecran,xe,199-ye,Couleur);



                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
PUT_DAC(PAL4);
Courbe;
END.





