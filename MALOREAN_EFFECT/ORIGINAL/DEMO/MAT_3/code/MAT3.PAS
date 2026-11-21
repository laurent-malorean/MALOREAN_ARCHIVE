{ þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                      þ
; þ                       DEMO MATHEMATICA 3                             þ
; þ                                                                      þ
; þ                      1993 MALOREAN EFFECT                            þ
; þ                                                                      þ
; þ     CREDIT POUR LA DEMO :  Volpone : CODE                            þ
; þ                            Toto    : CODE\GFX                        þ
; þ                            Sally   : MUSIC                           þ
; þ                                                                      þ
; þ                                                                      þ
; þ       RELEASE : Novembre 1993                                        þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
{$S-}

Uses CRT,DOS,CSCREEN,VARIABLE,GEST_GRAPH,GEST_DAC,GEST_SHOOT;

CONST A=99;
Const Max=99;
      Max2=Max div 2;

VAR F1 : Word;

PROCEDURE PAGE_CREDIT;
VAR WIN1  : OBJWIN;
VAR    TEXT                                   : TTEXT;

BEGIN;

ASM; MOV AX,3; INT 10h; END;
TEXT.FOND_ECRAN(ECRAN,BLANC,BRUN);
TEXT.WRITE(ECRAN,1,1,BLANC,BLEU,'                      MALOREAN EFFECT  : "MATEMATICA 3"                         ');
TEXT.WRITE(ECRAN,1,25,BLANC,BLEU,'                         RELEASE : DECEMBER 1993                                ');
WIN1.WIN4 (ECRAN,'CREDIT FOR THE DEMO',10,5,70,22,BLANC,BLEU,MAGENTA);
TEXT.WRITE(ECRAN,24,07,BLANC,MAGENTA,'VOLPONE          : CODE ');
TEXT.WRITE(ECRAN,24,09,BLANC,MAGENTA,'TOTO             : CODE ');

TEXT.WRITE(ECRAN,10,11,BLANC,BLEU,'                      SHAREWARE CREDIT                       ');
TEXT.WRITE(ECRAN,12,13,BLANC,MAGENTA,'PALETTES         : ALL PALETTES ARE RIPED FROM FRACTINT   ');
TEXT.WRITE(ECRAN,12,14,BLANC,MAGENTA,'PLAYER           : MOD-OBJ by MARK J COX ');
TEXT.WRITE(ECRAN,12,15,BLANC,MAGENTA,'TRACKER          : PROTRACKER 2.3 ');
TEXT.WRITE(ECRAN,12,16,BLANC,MAGENTA,'SCREEN CAPTURE   : SHOOT 2 By PHAM CONG-DUC ');

TEXT.WRITE(ECRAN,10,18,BLANC,BLEU,'                           HELLO TO                          ');
TEXT.WRITE(ECRAN,12,20,BLANC,MAGENTA,'Fbi,Silk,Weg,TmB,42 Crew,Sally,Jurassique Marc,Sun,Redlight');
TEXT.WRITE(ECRAN,12,21,BLANC,MAGENTA,'Mc2,Locked,Fafa');

PULSE:=0; REPEAT; UNTIL PULSE=250;
Clrscr;
END;





{***************************************************************************}
Procedure Pasm;  {extrait du repertoire flower}
VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     X                    : WORD;
     Xe,Ye                : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;
     X1,Y1                : WORD;
     X2                   : ARRAY [0..99]       Of WORD;
     T_COU1               : ARRAY [0..99,0..99] OF WORD;
     T_COU2               : ARRAY [0..99,0..99] OF WORD;

BEGIN;
put_dac(PAl4);
For Xe:=0 To 99 Do  X2[Xe]:=1 + ( ((300)*Xe) DIV 99 );

For xe:=0  TO 99 DO
For Ye:=xe TO 99 DO BEGIN;
                    T_COU1[Xe,Ye]:=2*(X2[Xe]+X2[Ye]);
                    T_COU2[Xe,Ye]:=((X2[Xe])*(X2[Xe]) + X2[Ye]*X2[Ye]);
                    END;

For X:=1   TO 300 DO
For xe:=0  TO 99  DO BEGIN; T_Xe :=Mul320[Xe];
For Ye:=Xe TO 99  DO BEGIN; T_Ye :=Mul320[Ye];
                            COU  :=(T_Cou1[Xe,Ye]*X) DIV T_COU2[Xe,Ye];
                            V  [ t_Ye +Xe] := Cou;
                            V  [ t_Xe +Ye] := Cou;
                            V  [-t_Ye +Xe] := Cou;
                            V  [-t_Xe +Ye] := Cou;
                            V  [-t_Ye -Xe] := Cou;
                            V  [-t_Xe -Ye] := Cou;
                            V  [ t_Ye -Xe] := Cou;
                            V  [ t_Xe -Ye] := Cou;
                     END;
                     END;
END;
{***************************************************************************}
Procedure moy_3;  {provient repertoire moyenne}
VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     Xe,Ye                : WORD;
     X                    : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;
     SOMME                : ARRAY[0..320] OF WORD;

BEGIN;
put_dac(BLUE);

SOMME[0]:=0;
For Xe:=1 To 320 Do SOMME[Xe]:=SOMME[Xe-1]+Xe;

FOR X:=1 to 200 DO BEGIN;
For xe:=1 to A Do  Begin; T_Xe   :=Mul320[Xe];
For Ye:=Xe TO A DO Begin;
                           T_Ye   :=Mul320[Ye];
                           COU:=SOMME[Xe+Ye]+SOMME[Xe+X];
                           V  [ t_Ye +Xe] := Cou;
                           V  [ t_Xe +Ye] := Cou;
                           V  [-t_Ye +Xe] := Cou;
                           V  [-t_Xe +Ye] := Cou;
                           V  [-t_Ye -Xe] := Cou;
                           V  [-t_Xe -Ye] := Cou;
                           V  [ t_Ye -Xe] := Cou;
                           V  [ t_Xe -Ye] := Cou;

                    End;
                    End;
                    END;
END;
{***************************************************************************}
PROCEDURE MOY_4;
VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     Xe,Ye                : WORD;
     X                    : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;
     SOMME                : ARRAY[0..320] OF WORD;

BEGIN;
put_dac(BLUE);
SOMME[0]:=0;
For Xe:=1 To 320 Do SOMME[Xe]:=SOMME[Xe-1]+Xe;

FOR X:=1 to 100 do
For xe:=1 to 99 Do  Begin; T_Xe   :=Mul320[Xe];
For Ye:=Xe TO 99 DO Begin;
                           T_Ye   :=Mul320[Ye];
                           COU:=X*SOMME[Xe+Ye] DIV (3*SOMME[Xe]);
                           V  [ t_Ye +Xe] := Cou;
                           V  [ t_Xe +Ye] := Cou;
                           V  [-t_Ye +Xe] := Cou;
                           V  [-t_Xe +Ye] := Cou;
                           V  [-t_Ye -Xe] := Cou;
                           V  [-t_Xe -Ye] := Cou;
                           V  [ t_Ye -Xe] := Cou;
                           V  [ t_Xe -Ye] := Cou;

                    End;
                    End;

END;

{***************************************************************************}
PROCEDURE RAC_3;
VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     Xe,Ye                : WORD;
     X                    : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;

BEGIN;
PUT_DAC(BLUE);


For xe:=1 to 99 Do  Begin; T_Xe   :=Mul320[Xe];
For Ye:=1 TO Xe DO Begin;
                           T_Ye   :=Mul320[Ye];
                           COU:=ROUND( 20*SQRT(SQRT(Xe*Xe+Ye*Ye)-Xe)+20*SQRT(SQRT(Xe*Xe+Ye*Ye)+Xe) );
                           V  [ t_Ye +Xe] := Cou;
                           V  [ t_Xe +Ye] := Cou;
                           V  [-t_Ye +Xe] := Cou;
                           V  [-t_Xe +Ye] := Cou;
                           V  [-t_Ye -Xe] := Cou;
                           V  [-t_Xe -Ye] := Cou;
                           V  [ t_Ye -Xe] := Cou;
                           V  [ t_Xe -Ye] := Cou;

                    End;
                    End;
END;
{***************************************************************************}
PROCEDURE RAC_4;
VAR  V                    : ARRAY [0..64000] Of BYTE  ABSOLUTE $A000:32160;
     Xe,Ye                : WORD;
     X                    : WORD;
     COU                  : BYTE;
     T_Xe,T_Ye            : WORD;

BEGIN;
put_dac(BLUE);
For xe:=1 to 99 Do  Begin; T_Xe   :=Mul320[Xe];
For Ye:=1 TO Xe DO Begin;
                           T_Ye   :=Mul320[Ye];
                           COU:=ROUND( 100*(SQRT(Xe*Xe+Ye*Ye)+Xe)/Ye  );
                           V  [ t_Ye +Xe] := Cou;
                           V  [ t_Xe +Ye] := Cou;
                           V  [-t_Ye +Xe] := Cou;
                           V  [-t_Xe +Ye] := Cou;
                           V  [-t_Ye -Xe] := Cou;
                           V  [-t_Xe -Ye] := Cou;
                           V  [ t_Ye -Xe] := Cou;
                           V  [ t_Xe -Ye] := Cou;

                    End;
                    End;
END;
{***************************************************************************}
PROCEDURE POLY8; {extrait de repertoire SH_CH}
VAR    f        : word;
       g        : word;
       c        : word ;
       Xe,Ye    : Word;
       cou      : Byte;


     {Variables pour la partie ES}
     Amin,Bmin,Amax,Bmax    : Real;
     pasX,pasY              : Real;
     module                 : real;
     NbIter                 : Byte;

     Px                     : Array [0..319] Of Real;
     Py                     : Array [0..199] Of Real;
     CosY                   : Array [0..199] Of REAL;
     SinX                   : Array [0..319] Of REAL;

     PartieA,PartieB        : Real;

BEGIN;
PUT_DAC(BLUE);
Amin:= -20;
Amax:=  20;
Bmin:= -20;
Bmax:=  20;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px   [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py   [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=50*Px[xe]*Px[xe]*Px[xe];
For ye:=0 to 199 do CosY [ye]:=50*Py[Ye]*Py[Ye]*Py[Ye];


For Xe:=0 to 319 Do Begin;
For Ye:=0 to 199 do Begin;
             {       Cou:=(Round(50*SinX[XE]) + round(50*CosY[Ye]) ) DIV 20;}
                    Cou:=ROUND(SinX[XE] +CosY[Ye] ) DIV 20;
                    VGA[Mul320[Ye]+Xe]:=Cou;
                    End;
                    End;
END;
{***************************************************************************}
PROCEDURE POLY10;  {extrait de repertoire SH_CH}
VAR    f        : word;
       g        : word;
       c        : word ;
       Xe,Ye    : Word;
       cou      : Byte;


     {Variables pour la partie ES}
     Amin,Bmin,Amax,Bmax    : Real;
     pasX,pasY              : Real;
     module                 : real;
     NbIter                 : Byte;

     Px                     : Array [0..319] Of Real;
     Py                     : Array [0..199] Of Real;
     CosY                   : Array [0..199] Of REAL;
     SinX                   : Array [0..319] Of REAL;

     PartieA,PartieB        : Real;
BEGIN;
PUT_DAC(BLUE);
Amin:= -40;
Amax:=  40;
Bmin:= -60;
Bmax:=  60;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px   [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py   [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Px[xe]*Px[xe]*Px[Xe];
For ye:=0 to 199 do CosY [ye]:=Py[Ye]*Py[Ye];


For Xe:=0 to 319 Do Begin;
For Ye:=0 to 100 do Begin;
                    Cou:=ROUND(SinX[XE])+  round(CosY[Ye]);
                    VGA[Mul320[Ye]+Xe]:=Cou;
                    VGA[Mul320[199-Ye]+Xe]:=Cou;
                    End;
                    End;
END;
{***************************************************************************}
PROCEDURE OLY14;  {extrait de repertoire SH_CH}
VAR    f        : word;
       g        : word;
       c        : word ;
       Xe,Ye    : Word;
       cou      : Byte;


     {Variables pour la partie ES}
     Amin,Bmin,Amax,Bmax    : Real;
     pasX,pasY              : Real;
     module                 : real;
     NbIter                 : Byte;

     Px                     : Array [0..319] Of Real;
     Py                     : Array [0..199] Of Real;
     CosY                   : Array [0..199] Of Real;
     SinX                   : Array [0..319] Of Real;

     PartieA,PartieB        : Real;

     Xecr,Yecr               : word;

     scrool : word;

BEGIN;
PUT_DAC(BLUE);
Xecr:=160;
Yecr:=150;

Amin:= -98;
Amax:=  1.1;
Bmin:= -98;
Bmax:=  1.1;

For scrool :=1 to 280 do begin;
Amin:=Amin-0.005*Abs(Amin);
Bmin:=Bmin-0.005*Abs(Bmin);

pasX:=(Amax-Amin)/Xecr;
pasY:=(Bmax-Bmin)/Yecr;
For xe:=0 to Xecr do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to Yecr do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to Xecr do SinX [xe]:=Px[xe]*Px[xe];
For ye:=0 to Yecr do CosY [ye]:=Py[Ye]*Py[Ye];


For Xe:=0 to (Xecr SHR 1) Do Begin;
For Ye:=0 to (Yecr SHR 1) do Begin;
                    Cou:=Round(SinX[XE]-CosY[Ye]);
                    VGA_CENTRE[Mul320[Ye]+Xe]:=Cou;
                    VGA_CENTRE[Mul320[Ye]-Xe]:=Cou;
                    VGA_CENTRE[-Mul320[Ye]+Xe]:=Cou;
                    VGA_CENTRE[-Mul320[Ye]-Xe]:=Cou;

                    End;
                    End;
end;
end;
{***************************************************************************}
PROCEDURE NEW6;  {Extrait du repertoire CONG}
Var    F,G      : word;
       CA       : byte;
       OFS      : WORD;
       S        : WORD;
       CARRE    : ARRAY[0..5000] OF LongInt;
       V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:75+20*320;

BEGIN; Put_dac (blue);
       For F:=0 To 250 Do CARRE[F]:=F*F;
       For S:=1 To 150 Do Begin;
       For G:=1 to 150 do BEGIN;
                          OFS:=Mul320[G];
                          For F:=1 to 150 do Begin;
                                             ca:=CARRE[F+S] - CARRE[f+g];
                                             INC (OFS);
                                             V[OFS]:=Ca;
                                             END;
                          END;
                          End;
End;
{***************************************************************************}
PROCEDURE NEW14;  {Extrait du repertoire CONG}
Var    F,G      : word;
       CA       : byte;
       OFS      : WORD;

BEGIN; put_dac (BLUE);
       For G:=1 to 200 do BEGIN;
                          OFS:=Mul320[G];
                          For F:=1 to 320 do Begin;
                                             ca:=0;
                                             repeat;
                                             inc(ca);
                          until ((g*g-f*f) MOD f< CA) or (ca=250);
                                             Vga[OFS+f]:=Ca;
                                             END;
                          END;
END;
{***************************************************************************}
{************   ROTATION PART  extrait de repertoire "rotation"   **********}
{***************************************************************************}

{***************************************************************************}
procedure rot_2;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     cou : word;

BEGIN;
put_dac(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=Xe;
                   Ty[Xe]:=Xe;
                   End;


For x:=1 to 100 DO   Begin
                     InterX:=Tx[0];
                     InterY:=Ty[99];
                     For Xe:=1 To 99 Do Tx[Xe-1]:=Tx[Xe];
                     For Xe:=0 To 98 Do Ty[Xe]:=Ty[Xe+1];
                     Tx[99]:=InterX;
                     Ty[0]:=InterY;

For xe:=0 to 99 Do  Begin;
For Ye:=1 TO Xe DO Begin;
                    cou:=Tx[Xe]+Ty[Ye];
                    Vga[Mul320[Ye+100]+Xe+160]:=Cou;
                    Vga[Mul320[Xe+100]+Ye+160]:=cou;
                    Vga[Mul320[100-Ye]+Xe+160]:=Cou;
                    Vga[Mul320[100-Xe]+160+Ye]:=Cou;
                    Vga[Mul320[100-Ye]+-Xe+160]:=Cou;
                    Vga[Mul320[-Xe+100]-Ye+160]:=cou;
                    Vga[Mul320[100+Ye]-Xe+160]:=Cou;
                    Vga[Mul320[100+Xe]+160-Ye]:=Cou;

                   end;
                   end;
                   end;
END;
{***************************************************************************}
procedure rot_9;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
put_dac(VOLCANO);
For Xe:=0 to 99 Do Begin; Tx[Xe]:=5*Xe;
                          Ty[Xe]:=ROUND(150*Cos(Xe/10));
                          End;

For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   V[Mul320[Ye]+Xe]:=Cou;
                   V[Mul320[Xe]+Ye]:=cou;
                   V[-Mul320[Ye]+Xe]:=Cou;
                   V[-Mul320[Xe]+Ye]:=Cou;
                   V[-Mul320[Ye]-Xe]:=Cou;
                   V[-Mul320[Xe]-Ye]:=cou;
                   V[Mul320[Ye]-Xe]:=Cou;
                   V[Mul320[Xe]-Ye]:=Cou;
                   end;
                   end;

END;

{***************************************************************************}
procedure rot_20;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
put_dac(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=Round(x*Sin(Xe/10));
                   Ty[Xe]:=ROUND(150*Cos(Xe/10));
                   End;


For x:= 1 to 100 do begin;
For Xe:=1 to 99 Do  Tx[Xe]:=(xe+x) mod xe;
For Xe:=0 to 99 Do  Ty[Xe]:=ROUND( X*cos(xE/20) );
For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   V[Mul320[Ye]+Xe]:=Cou;
                   V[Mul320[Xe]+Ye]:=cou;
                   V[-Mul320[Ye]+Xe]:=Cou;
                   V[-Mul320[Xe]+Ye]:=Cou;
                   V[-Mul320[Ye]-Xe]:=Cou;
                   V[-Mul320[Xe]-Ye]:=cou;
                   V[Mul320[Ye]-Xe]:=Cou;
                   V[Mul320[Xe]-Ye]:=Cou;
                   end;
                   end;
                   end;

END;

{***************************************************************************}
procedure rot_14;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
PUT_DAC(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=Round(150*Sin(Xe/10));
                   Ty[Xe]:=ROUND(150*Cos(Xe/10));
                   End;


For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   V[Mul320[Ye]+Xe]:=Cou;
                   V[Mul320[Xe]+Ye]:=cou;
                   V[-Mul320[Ye]+Xe]:=Cou;
                   V[-Mul320[Xe]+Ye]:=Cou;
                   V[-Mul320[Ye]-Xe]:=Cou;
                   V[-Mul320[Xe]-Ye]:=cou;
                   V[Mul320[Ye]-Xe]:=Cou;
                   V[Mul320[Xe]-Ye]:=Cou;
                   end;
                   end;
END;

{***************************************************************************}
procedure rot_15;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     TSIN     : ARRAY [0..99] Of real;
     InterX,InterY    : Byte;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
put_dac(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=Round(x*Sin(Xe/10));
                   Ty[Xe]:=ROUND(150*Cos(Xe/10));
                   TSin[Xe]:=SIN(Xe/10);
                   End;


For x:= 1 to 400 do begin;
For Xe:=0 to 99 Do  Tx[Xe]:=Round(x*TSin[Xe]);

For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   V[Mul320[Ye]+Xe]:=Cou;
                   V[Mul320[Xe]+Ye]:=cou;
                   V[-Mul320[Ye]+Xe]:=Cou;
                   V[-Mul320[Xe]+Ye]:=Cou;
                   V[-Mul320[Ye]-Xe]:=Cou;
                   V[-Mul320[Xe]-Ye]:=cou;
                   V[Mul320[Ye]-Xe]:=Cou;
                   V[Mul320[Xe]-Ye]:=Cou;
                   end;
                   end;
                   end;

END;

{***************************************************************************}
procedure rot_16;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     TSIN     : ARRAY [0..99] Of real;
     InterX,InterY    : Byte;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
PUT_DAC(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=Round(x*Sin(Xe/10));
                   Ty[Xe]:=ROUND(150*Cos(Xe/10));
                   TSin[Xe]:=SIN(Xe/10);
                   End;


For x:= 1 to 250 do begin;
For Xe:=0 to 99 Do  Tx[Xe]:=Round(x*Sin(x*Xe/10)/4);
For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   V[Mul320[Ye]+Xe]:=Cou;
                   V[Mul320[Xe]+Ye]:=cou;
                   V[-Mul320[Ye]+Xe]:=Cou;
                   V[-Mul320[Xe]+Ye]:=Cou;
                   V[-Mul320[Ye]-Xe]:=Cou;
                   V[-Mul320[Xe]-Ye]:=cou;
                   V[Mul320[Ye]-Xe]:=Cou;
                   V[Mul320[Xe]-Ye]:=Cou;

                   end;
                   end;
                   end;
END;


{***************************************************************************}


BEGIN;
GraphMode;
LoadShoot('Data.000'); Delay(5000); cls(0);
cls(0); Moy_3;
        RAC_3;  Delay(2000);
        Moy_4;
        RAC_4;  Delay(2000);

cls(0); LoadShoot('Data.004'); Delay(5000); cls(0);

cls(0); PAsm;

cls(0); LoadShoot('Data.001'); Delay(5000); cls(0);
        OLY14;  Delay(500);
        POLY8;  Delay(5000);
        POLY10; Delay(5000);

cls(0); LoadShoot('Data.005'); Delay(5000); cls(0);

cls(1); New6;
cls(1); New14;

cls(0); LoadShoot('Data.002'); Delay(5000); cls(0);

cls(0); rot_2;  delay(2000);
        rot_9;  delay(2000);
        rot_20; delay(2000);
        rot_14; delay(2000);
        rot_15; delay(2000);
        rot_16; delay(2000);

Cls(0); LoadShoot('Data.003'); Delay(5000); cls(0);
PAGE_CREDIT;
END.
