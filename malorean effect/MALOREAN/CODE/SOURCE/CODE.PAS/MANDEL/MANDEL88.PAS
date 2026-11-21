Program Mandel;

Uses CGraph,crt;


Var Cga                    : tGraphVga;


Procedure Courbe;
Var
Xe,Ye                  : LongInt;
X,Xp,Y                 : LongInt;
Amin,Bmin,Amax,Bmax    : LongInt;
pasX,pasY              : Real;
module                 : LongInt;
NbIter                 : LongInt;

Ofset1                 : Word;
moi : byte;

Px                     : Array [0..319] Of LongInt;
Py                     : Array [0..199] Of LongInt;
F : Integer;
couleur : byte;
Begin; {1}

Ofset1:=0;
Amin:= Round( -2*2048  );
Amax:= Round(  0.5*2048  );
Bmin:= Round( -1.2*2048);
Bmax:= Round(  1.2*2048);
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));

moi:=0;

For Ye:=0 to 100 Do
For Xe:=0 to 320 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<35)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                If moi=0 then Xp:=( (x*x+y*y)  div 2048 )     +Px[Xe];;
                                 If moi=1 then Xp:=( (x*x-y*y)  div 2048 )     +Px[Xe];;
                                 If moi=2 then Xp:=( (x*x-y*x)  div 2048 )     +Px[Xe];;

                                if moi=0 then  Y:=( (X*y    ) DIV 1024  )  +  Py[Ye];
                                if moi=1 then  Y:=( (X*y    ) DIV 1024  )  +  Py[Ye];
                                if moi=2 then  Y:=( (X*y*5    ) DIV 1024  )  +  Py[Ye];

                                 X:=Xp;
                                 Inc(NbIter,1);
                                 moi:=moi+1;
                                 if moi=3 then moi:=0;
                                 If moi=0 then module:=SQR(x)+sqr(y);
                                 If moi=1 then module:=SQR(x)-sqr(y);
                                 If moi=2 then module:=SQR(x);


                                 End;   {1.1.1.1}

couleur:=Nbiter And 255 ;
CGA.putpixel(Vga_Ecran,xe,ye,Couleur);
CGA.putpixel(Vga_Ecran,xe,199-ye,Couleur);


                                        End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
Courbe;
delay(5000);
END.





