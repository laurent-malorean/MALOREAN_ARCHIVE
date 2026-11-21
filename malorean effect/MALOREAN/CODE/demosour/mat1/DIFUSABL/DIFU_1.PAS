{ þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                      þ
; þ                           MATEMATICA 1                               þ
; þ                                                                      þ
; þ                      1993 MALOREAN EFFECT                            þ
; þ                                                                      þ
; þ     CREDIT POUR LA DEMO /  Volpone : CODE                            þ
; þ                                                                      þ
; þ     MERCI A : SALLY-LEZHEMUS-THE MASQUED CODER-TOTO-SUNDRD           þ
; þ                                                                      þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}

Uses GEST_DAC,
     GEST_Graph,
     DOS,
     CRT;


type  tf=Array [-8000..8000] Of LongInt;

VAR Xe,Ye                  : LongInt;
    F : Integer;
    Pulse       : Word ABSOLUTE $0040:$006C;
{**************************************************************************}
Procedure FractNbEntier;
Var
    X,Xp,Y                 : LongInt;
    Amin,Bmin,Amax,Bmax    : LongInt;
    pasX,pasY              : Real;
    modmax                 : Longint;
    module                 : LongInt;
    NbIter                 : LongInt;

    Ofset1                 : Word;
    moi : byte;

    Px                     : Array [0..319] Of LongInt;
    Py                     : Array [0..199] Of LongInt;
    couleur : byte;

Procedure Clear;
VAR BB : ARRAY [1..16000] of LongInt ABSOLUTE $A000:0000;
    F  : Integer;
BEGIN;  For f:=1 to 16000 Do BB[f]:=0;
END;


Procedure Courbe1;
Begin;
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
For Xe:=0 to 319 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<35)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                If moi=0 then Xp:=( (x*x+y*y)  div 2048 ) +Px[Xe];
                                If moi=1 then Xp:=( (x*x-y*y)  div 2048 ) +Px[Xe];
                                If moi=2 then Xp:=( (x*x-x*y)  div 2048 ) +Px[Xe];

                                 Y:=( (X*y    ) DIV 1024  )  +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter);
                                 Inc(Moi);
                                 if moi=2 then moi:=0;
                                 If moi=0 then module:=SQR(x)+sqr(y);
                                 If moi=1 then module:=SQR(x)-sqr(y);
                                 If moi=2 then Module:=x;
                                 End;   {1.1.1.1}

couleur:=Nbiter And 255 ;
VGA_Ecran[Mul320[ye]+xe]:=Couleur;
Vga_Ecran[Mul320[198-ye]+xe]:=Couleur;


                                        End;    {1.1.1}

End; {1}
{---------------------------------------------------------------------}
Procedure Courbe2;
Begin;

Amin:= Round( -2.2*2048    );
Amax:= Round(  0.7*2048  );
Bmin:= Round( -1.5*2048  );
Bmax:= Round(  1.5*2048  );

pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);


For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Ye:=0 to 100 Do begin;
For Xe:=0 to 319 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<35)
                            and (Module<16777216) Do Begin
                                 Xp:=( (x*x-y*y)  div (2048) )     +Px[Xe];
                                 Y:=( ((X*Y     ) DIV 1024  ))  +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)-( sqr(y) Shl 4);
                                 End;

If module>16777216 then couleur:=Nbiter And 255 ;
If (module<16777216) and (y<>0) then couleur:=x Mod y;

Vga_Ecran[Mul320[ye]+xe]:=couleur;
Vga_Ecran[Mul320[199-ye]+xe]:=Couleur;


                                        End;
end;
End;
{--------------------------------------------------------------}
Procedure Courbe5;
Begin; {1}

Amin:= Round( -2*2048  );
Amax:= Round(  1*2048  );
Bmin:= Round( -1.2*2048);
Bmax:= Round(  1.2*2048);
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
                     While      (nbiter<15)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                 Xp:=( (x*x-x*y)  shr 11 )+Px[Xe];
                                 Y:=( (X*Y    ) shr 11 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+y*y;
                                 End;   {1.1.1.1}

couleur:=   NbIter And 250;
Vga_Ecran[xe+Mul320[ye]]:=Couleur;
Vga_Ecran[xe+Mul320[199-ye]]:=Couleur;



                                        End;    {1.1.1}

End; {1}
{----------------------------------------------------------------}
Procedure Courbe6;
Begin; {1}

Amin:= Round( -3*2048  );
Amax:= Round(  2*2048  );
Bmin:= Round( -2.2*2048);
Bmax:= Round(  2.2*2048);
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
                     While      (nbiter<55)
                            and (Module<16000000) Do Begin {1.1.1.1}
                                 Xp:=( (x*x-y*y)  div 2048 )+Px[Xe];
                                 Y:=( (X*y    ) div 1024  )+ Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)+sqr(y);
                                 End;   {1.1.1.1}

couleur:=NbIter And 255;
Vga_Ecran[xe+Mul320[ye]]:=Couleur;
Vga_Ecran[xe+Mul320[199-ye]]:=Couleur;
                                        End;    {1.1.1}

End; {1}
{---------------------------------------------------------------------}
Procedure Courbe7;
Begin; {1}

Amin:= Round( -2*512  );
Amax:= Round(  1*512  );
Bmin:= Round( -1.2*512);
Bmax:= Round(  1.2*512);
pasX:=Round( 512*(Amax-Amin)/320);
pasY:=Round( 512*(Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)) *512);
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)) *512);




For Xe:=0 to 319 Do
For Ye:=0 to 200 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<7)
                            and (Module<4) Do Begin {1.1.1.1}
                                              Xp:=(SQR(x)-SQR(Y)+Px[xe]) DIV 512;
                                              Y:=(2*X*Y   +Py[ye]) DIV 512;
                                              X:=Xp;
                                              NbIter:=NbIter+1;
                                              module:=SQR(x)+SQR(y);
                                              End;   {1.1.1.1}

putpixel(xe,ye,NbIter AND 10);
                                        End;    {1.1.1}

End ; {1}
{--------------------------------------------------------------}
Procedure Courbe8;
Begin; {1}

Amin:= Round( -2*1024  );
Amax:= Round(  1*1024  );
Bmin:= Round( -1.2*1024);
Bmax:= Round(  1.2*1024);
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Xe:=0 to 160 Do
For Ye:=0 to 100 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<35)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                 Xp:=( (x*x-SQR(Y))  div 1024 )+Px[Xe];
                                 Y:=( (X*Y    ) DIV 1024 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+sqr(y);
                                 End;   {1.1.1.1}

couleur:=   NbIter And 250;
putpixel(xe,ye,Couleur);
putpixel(xe,199-ye,Couleur);
putpixel(319-xe,ye,Couleur);
putpixel(319-xe,199-ye,Couleur);

                                       End;    {1.1.1}
End; {1}
{----------------------------------------------------------}
Procedure Courbe9;
Var
car : ^tf;
Begin; {1}
new(car);
for f:=-8000 to 8000 do car^[f]:=f*f div 2048;
Amin:= Round( -2*2048  );
Amax:= Round(  1*2048  );
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
                     While      (nbiter<150)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                 Xp:=( (x*x-SQR(Y))  shr 11 )+Px[Xe]; {shr 12}
                                 Y:=( (X*Y    ) DIV  1024 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+car^[y];
                                 End;   {1.1.1.1}

couleur:=  ( NbIter And 30 )   shl 4;
putpixel(xe,ye,Couleur);
putpixel(xe,199-ye,Couleur);



                                        End;    {1.1.1}

End; {1}
{--------------------------------------------------------------}
PROCEDURE ESFRAC2;
CONST

MUL=256;
MUL2=MUL DIV 2;

BEGIN;
Amin:= Round( -2  *MUL    );
Amax:= Round(  0.5*MUL  );
Bmin:= Round( -1.2*MUL  );
Bmax:= Round(  1.2*MUL  );
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));
For Ye:=0 to 99 Do
For Xe:=0 to 319 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<2*mul*mul) Do Begin
                                 Xp:=( (x*x-y*y)  div MUL )     +Px[Xe];
                                 Y:=( ((X*Y     ) DIV MUL2   ))  +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)-( sqr(y) shl 4);
                                 End;

If module>16777216 then couleur:=Nbiter And 255 ;
If (module<16777216) and (y<>0) then couleur:=x mod y;

putpixel(xe,ye,Couleur);
putpixel(xe,199-ye,Couleur);
                                        End;
End;

{--------------------------------------------------------------}
PROCEDURE ESFRAC5;
CONST    MUL=2048;
         MUL2=MUL DIV 2;
BEGIN;
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
putpixel(xe,ye,Couleur);
                                        End;
END;
{--------------------------------------------------------------}
PROCEDURE L8;
BEGIN;
Amin:= Round( -2*2048  );
Amax:= Round(  -1.3*2048  );
Bmin:= Round( -0.2*2048);
Bmax:= Round(  0.2*2048);
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
                     While      (nbiter<35)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                 Xp:=( (x*x-x*y)  div 2048 )+Px[Xe];
                                 Y:=( (X*Y    ) DIV 1024 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+sqr(y);
                                 End;   {1.1.1.1}

couleur:=   NbIter And 15;
putpixel(xe,ye,Couleur);
putpixel(xe,199-ye,Couleur);
                                       End;    {1.1.1}
END;
{---------------------------------------------------------------}
PROCEDURE L15;
BEGIN;
Amin:= Round( -2*2048  );
Amax:= Round(  -1*2048  );
Bmin:= Round( -0.6*2048);
Bmax:= Round(  0.6*2048);
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));



For Xe:=0 to 160 Do
For Ye:=0 to 100 do Begin; {1.1.1}
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<57)
                            and (Module<16777216) Do Begin {1.1.1.1}
                                 Xp:=( (x*x-x*y)  shr 11 )+Px[Xe];
                                 Y:=( (X*Y    ) shr 11 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+y*y;
                                 End;   {1.1.1.1}

couleur:=   NbIter and 255 ;
putpixel(xe,ye,Couleur);
putpixel(xe,199-ye,Couleur);
putpixel(319-xe,ye,Couleur);
putpixel(319-xe,199-ye,Couleur);
                                        End;    {1.1.1}

END;
{---------------------------------------------------------------}
PROCEDURE MAN_MAG_;
CONST C1=65536;
      c2=c1 div 2;
VAR   merde1 : longint;
      merde1bis : integer;

BEGIN;
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
                                Merde1:=x*x-y*y;
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
                                 Xp:=( merde1bis )+Px[Xe];
                                 Y:=( (X*Y    ) div c2 )+ Py[Ye];
                                 X:=Xp;
                                 NbIter:=NbIter+1;
                                 module:=SQR(x)+y*y;
                                 End;   {1.1.1.1}

couleur:= NbIter;
putpixel(xe,ye,Couleur);
putpixel(xe,199-ye,Couleur);



                                        End;    {1.1.1}
END;
{---------------------------------------------------------------}
PROCEDURE MANDEL10;
BEGIN;
Amin:= Round( -3*2048  );
Amax:= Round(  2*2048  );
Bmin:= Round( -2*2048  );
Bmax:= Round(  2*2048  );
pasX:=(Amax-Amin)/320;
pasY:=( (Bmax-Bmin)/200);
For xe:=0 to 319 do Px [xe]:=Round  ( (amin+pasx*(xe+1)));
For ye:=0 to 199 do Py [ye]:=Round  ( (bmin+pasy*(ye+1)));


For Ye:=0 to 99 Do
For Xe:=1 to 319 do Begin;
                     X:=0;
                     Y:=0;
                     module:=0;
                     NbIter:=0;
                     While      (nbiter<50)
                            and (Module<16777216) Do Begin
                                 Xp:=( (x*x-y*y)  div (2048) )     +Px[Xe];
                                 Y:=( ((X*Y     ) DIV 1024   ))  +  Py[Ye];
                                 X:=Xp;
                                 Inc(NbIter,1);
                                 module:=SQR(x)-( sqr(y) shl 4);
                                 End;

Couleur:=y shr 5  + nbiter;
Vga_Ecran[Mul320[ye]+xe]:=Couleur;
Vga_Ecran[Mul320[199-ye]+xe]:=Couleur;

END;
end;


BEGIN;
GraphMode;
       CLS(0);
       PUT_DAC   (pal12);    Courbe1;  Delay(2000);
Clear; PUT_DAC   (volcano);  Courbe2;  Delay(2000);
CLEAR; PUT_DAC   (Default);  Courbe5;  Delay(2000);
Clear;                    Courbe6;  Delay(2000);
Clear;                    Courbe7;  Delay(2000);
Clear;                    Courbe8;  Delay(2000);
Clear;                    Courbe9;  Delay(2000);
Clear; PUT_DAC   (Volcano);  EsFrac2;  Delay(2000);
Clear; PUT_DAC   (Pal4);     EsFrac5;  Delay(2000);
Clear; PUT_DAC   (Default);  L8;       Delay(2000);
Clear;                    L15;      Delay(2000);
Clear; PUT_DAC   (Pal1);     Man_Mag_; Delay(2000);
Clear; PUT_DAC   (Volcano);  Mandel10; Delay(2000);
Clear;
GEST_GRAPH.TextMode;
END;
{**************************************************************************}
BEGIN;
FractNbEntier;

END.






