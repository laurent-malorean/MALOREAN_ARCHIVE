Program Mandel;

Uses CGraph,Crt;

CONST C1=65536;
      c2=c1 div 2;

Var Cga                    : TGraphvga;


Procedure Courbe;
Var
Xe,Ye                  : LongInt;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : Real;
module                 : LongInt;
NbIter                 : LongInt;

merde1 : longint;
merde1bis : integer;

Px                     : Array [0..319] Of LongInt;
Py                     : Array [0..199] Of LongInt;
F : Integer;
couleur : byte;
Begin; {1}

Amin:= Round( -2*c1  );
Amax:= Round(  1*c1  );
Bmin:= Round( -2*c1);
Bmax:= Round(  2*c1);
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Xe:=0 to 319 Do
For Ye:=0 to 100 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<20)
                            and (Module<1000000000) Do Begin {1.1.1.1}
                                 Xp:=((x*x-y*y) div c1  )+Px[Xe];
                                 merde1:=x*y;
                                ASM ;
                                push ds
                                push si
                                MOV AX,SEG( merde1);
                                MOV ES,AX
                                MOV DI,Offset(merde1);
                                ADD DI,8
                                MOV AX,SEG(merde1bis);
                                MOV DS,AX
                                MOV Si,Offset(merde1bis);
                                MOV AX,es:[DI]
                                MOV DS:[SI],AX

                                pop si
                                pop ds
                                end;
                                 Y:= (merde1bis )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+y*y;
                                 End;   {1.1.1.1}

couleur:= NbIter;
CGA.putpixel(Vga_Ecran,xe,ye,Couleur);
CGA.putpixel(Vga_Ecran,xe,199-ye,Couleur);



                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
LoadPal('e:\tp\pal\pal1.pal');
Courbe;
repeat;
until keypressed;
END.





