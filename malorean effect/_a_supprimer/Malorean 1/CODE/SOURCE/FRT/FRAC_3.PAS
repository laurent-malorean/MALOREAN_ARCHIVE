Program Mandel;

Uses Gest_Graph,DAC_CODE,DAc_FRAc,crt;



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
Amax:= Round(  -0.5*2048  );
Bmin:= Round( -1.5*2048);
Bmax:= Round(  1.5*2048);
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Xe:=0 to 319 Do
For Ye:=0 to 100 do Begin; {1.1.1}
                     X:=Px[Xe]+5*Ye+Xe;
                     Y:=Py[Ye]+5*Xe+Ye;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<200)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                 Xp:=( (X*X-y*y)  DIV 2048 )+Px[Xe];
                                 Y:=( (X*Y    ) DIV 1024 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=X*X+Y*Y;
                                 End;   {1.1.1.1}

If Nbiter<500 then Couleur:= NbIter  + (X+Y) div 150
              else couleur:=(module) div 5000 +(x+y) div 10 +(Px[Xe]) div 10;
putpixel(xe,ye,Couleur);
putpixel(xe,199-ye,Couleur);



                                        End;    {1.1.1}

End; {1}


BEGIN;
GraphMode;
PUT_DAC(PAL4);
Courbe;
delay(10000);
END.





