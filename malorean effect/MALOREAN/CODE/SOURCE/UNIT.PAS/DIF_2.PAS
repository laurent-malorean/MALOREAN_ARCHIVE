{ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                      ■
; ■                       DEMO MATEMATICA 2                             ■
; ■                                                                      ■
; ■                      1993 MALOREAN EFFECT                            ■
; ■                                                                      ■
; ■     CREDIT POUR LA DEMO /  Volpone : CODE                            ■
; ■                            Toto    : CODE\GFX                        ■
; ■                            SunDrd  : MUSIC                           ■
; ■                                                                      ■
; ■     MERCI A : SALLY-LEZHEMUS-THE MASQUED CODER                       ■
; ■                                                                      ■
; ■       RELEASE:                                                       ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■}



Uses CSCREEN,CGRAPH,CRT,DOS;


{$M $4000,0,0} 			{16k stack, no heap - adjust as needed }
{$L MOD-obj.OBJ} 	        { Link in Object file }

{PARTIE DE CORESPONDANCE AVEC DEMO 1}
TYPE TCONFIG = RECORD
              FREQUENCE : BYTE    ;
              COPRO     : BOOLEAN ;
              FRACTAL   : BOOLEAN ;
              PERPETUEL : BOOLEAN ;
              ARETE     : BYTE ;
              END;

VAR CONFIG                      : TCONFIG ;
VAR       Fichier     : File;

CONST CMIX : ARRAY[1..9] OF INTEGER =(8000,10000,12000,15000,17000,20000,22000,25000,30000);


type   {Type pour la fractale part}
       tf=Array [-8000..8000] Of LongInt;

VAR    {Variables pour les PALETTES}
       DEFAULT : T2_PALETTE;
       VOLCANO : T2_PALETTE;
       BLUE    : T2_PALETTE;
       PAL1    : T2_PALETTE;
       PAL2    : T2_PALETTE;
       PAL4    : T2_PALETTE;
       PAL12   : T2_PALETTE;



VAR    {Variables pour le tracker}
       dev,mix,stat,pro,loop : integer;
       md : string;
       ch: char;

       {             }

       Touche  : Char ;
       A       : Byte  ;
       Max2    : Byte  ;

      {Variable pour carle}
       V          : Type_Graph_Ecran  ABSOLUTE $A000:$0000;
       VGA        : TGraphVga;
       f          : word;
       g          : word;
       c          : word ;
       cou        : Byte;
       Mul1       : Array [0..199] Of Word;
       Mul2       : Array [0..199] Of Word;
       Ofset1_f   : Word;
       Ofset2_f   : Word;
       Ofset1_g   : Word;
       Ofset2_g   : Word;

       {Variable pour strange il utilise aussi les variables de carle}
       cou1,cou2,cou3 : Byte;
       Tx,Ty :array[0..99] Of Byte;

      {Variables pour ExPoly}
     Ax       : ARRAY [0..319] Of Word;
     Bx       : ARRAY [0..319] Of Word;
     Cx       : ARRAY [0..319] Of Word;
     Ay       : ARRAY [0..199] Of Word;
     By       : ARRAY [0..199] Of Word;
     Cy       : ARRAY [0..199] Of Word;
     Az       : ARRAY [0..319] Of Word;
     Bz       : ARRAY [0..319] Of Word;
     Cz       : ARRAY [0..319] Of Word;
     Xe,Ye    : WORD;
     X        : Word;
     P1,P2    : Word;
     P3       : Word;

     {Variables pour les variations de palette}
     Palette  : T2_Palette;
     PalInter : T2_Palette;

     bol : boolean;

     {Variables pour cong}
     ca   : Byte;

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



VAR Ta,Tb,Tc,Td : Word;
VAR Resultat    : Word;
VAR Pulse       : Word ABSOLUTE $0040:$006C;
VAR PulseI      : Word;
VAR PulseF      : Word;

{ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                      ■
; ■                         INTERFACE PART                               ■
; ■                                                                      ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■}


{$F+}                                    { Exploite le modèle FAR-Call }
{-------------------------------------------------------------------------}
Procedure SpeedClavier( Rate : byte ) ;

begin
 inline(
        $32/$D2/$B4/$F3/$FA/$E8/$13/$00/$75/$0A/$8A/$66/$06/$E8/
        $0B/$00/$75/$02/$FE/$C2/$FB/$88/$56/$FF/$EB/$27/$90/$51/
        $53/$B3/$03/$33/$C9/$E4/$64/$A8/$02/$E0/$FA/$8A/$C4/$E6/
        $60/$E4/$64/$A8/$01/$E1/$FA/$E4/$60/$3C/$FA/$74/$07/$FE/
        $CB/$75/$E6/$80/$CB/$01/$5B/$59/$C3
       );
end;


{-------------------------------------------------------------------------}


{------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
------------------------------------------------------------------------}
{$F+} 				{ force calls to be 'far'}
procedure modvolume(v1,v2,v3,v4:integer); external ; {Can do while playing}
procedure moddevice(var device:integer); external ;
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); external ;
procedure modstop; external ;
procedure modinit; external;


{$F-}

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CHARGE_ALL_PALETTES;
BEGIN;    Assign(Fichier,'DATA.000');
          Reset(Fichier, 1);
          BlockRead(Fichier,DEFAULT,768);
          BlockRead(Fichier,VOLCANO,768);
          BlockRead(Fichier,BLUE   ,768);
          BlockRead(Fichier,PAL1   ,768);
          BlockRead(Fichier,PAL2   ,768);
          BlockRead(Fichier,PAL4   ,768);
          BlockRead(Fichier,PAL12  ,768);
          Close(Fichier);
END;
{------------------------------------------------------------------------}
PROCEDURE PAL   (NAME   : T2_PALETTE);
VAR     Vga         :  ObjPalette;
BEGIN;  VGA.SetDAc (0,255,NAME);
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE LitMod ;
PROCEDURE UTIL1;
BEGIN;    Md:=('tknodoom.mod');
          mix := CMIX[CONFIG.FREQUENCE];   {use 10000 normally }
          pro := 0; {Leave at 0}
          loop :=4; {4 means mod will play forever}
          modvolume (255,255,255,255);    { Full volume }
	  modsetup ( stat, dev, mix, pro, loop, md );
END;
BEGIN;    modinit;
	  moddevice ( dev ); { Returns device number in DEV or 255 if 'no sound' }
          if (dev =255) then Else UTIL1;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CLS;
VAR VW : ARRAY [1..32000] Of WORD ABSOLUTE $A000:0000;
Var F: Word;
BEGIN;
For f:=1 to 32000 do VW[F]:=0;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE MODIFA;
BEGIN;
Touche:=readkey;
If (touche=#43) AND (A<100) then Begin;
                                 Inc(a);
                                 Touche:=#0;
                                 end;
If (touche=#45) AND (A>30) then Begin;
                           For F:=(160-A) To (160+A) DO Begin;
                                             V[t[100-A]+f]:=0;
                                             V[t[100+A]+f]:=0;
                                             END;
                           For F:=(100-A) To (100+A) DO Begin;
                                             V[t[f]+160-A]:=0;
                                             V[t[f]+160+A]:=0;
                                             END;


                                 Dec(a);
                                 Touche:=#0;
                                 end;
Max2:=A SHR 1;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE0;
BEGIN;
for c:=1 to 400 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f+g-c) or C*F*g;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;

                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE1;
BEGIN;
for c:=1 to 260 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f-g)*(g-c)*(c-f) and f+g*c;;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE2;
BEGIN;
for c:=1 to 190 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f-g)*(g-c)*(c-f)  xor f-g;;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE3;
BEGIN;
for c:=1 to 100 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f+g+g)*(f+f+g+c+c+c);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE5;
BEGIN;
for c:=1 to 100 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f-g)*(g-c)*(c-f) and f*g+c;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE8;
BEGIN;
for c:=1 to 310 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (c+(c-f)*g)  ;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE12;
BEGIN;
for c:=1 to 350 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f*(c-g));
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE13;
BEGIN;
for c:=1 to 300 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=f*g*c;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE14;
BEGIN;
for c:=1 to 300 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f*(c-g)) and f*g;;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE15;
BEGIN;
for c:=1 to 300 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f*(c-g)) or f*g;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE16;
VAr C1 : Word;
BEGIN;
C1:=0;
for c:=1 to 100 do Begin;
                   Inc(c1);
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f*(c1-g)) div (f*g+1);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
                          If c1=1 then begin;
                                       pulse:=0;
                                       repeat;
                                       until pulse=40;
                                       end;
If keypressed then ModifA;
                    end;
for c:=100 to 300 do Begin;
                     Inc(c1,40);
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f*(c1-g)) div (f*g+1);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
for c:=300 to 380 do Begin;
                     Inc(c1,500);
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f*(c1-g)) div (f*g+1);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE17;
BEGIN;
for c:=1 to 600 do Begin;
                   Inc(c,5);
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f+(c-g)) mod (f*g+1);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE18;
BEGIN;
for c:=1 to 150 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f and (c-g)) mod (f*g+1);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE19;
BEGIN;
for c:=1 to 130 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f and (c mod g)) ;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE20;
BEGIN;
for c:=1 to 120 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f+g+g) mod (1+f+f+g+c+c+c) *c;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE21;
BEGIN;
for c:=1 to 180 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f+g+g) and (1+f+f+g+c+c+c);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE24;
BEGIN;
for c:=1 to 100 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f+g+g+g)*(f+f+g+c);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE25;
BEGIN;
for c:=1 to 120 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f*g mod c) mod ((f+c mod g)+1);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE26;
BEGIN;
for c:=1 to 140 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f*g mod c) or ((f mod g)+1);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE27;
BEGIN;
for c:=1 to 105 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(c mod f)*(c mod g);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE28;
BEGIN;
for c:=1 to 130 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=f and g mod c;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE30;
BEGIN;
for c:=1 to 300 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(c-f*g) + (g-c*f) + (f-g*c);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE33;
BEGIN;
for c:=1 to 150 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(c-f*(g-c*f));
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE39;
BEGIN;
for c:=1 to 100 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:= (f-(c*g shl 2))*g*g;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE41;
BEGIN;
for c:=1 to 160 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f-c)*g*g;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE42;
BEGIN;
for c:=1 to 40 do Begin;
    for f:=1 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f+g+g) mod (f+f+g+c+c) * c;;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE46;
BEGIN;
for c:=1 to 200 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f-g) and (g-f) and (f-c) or (g-c);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CARLE47;
BEGIN;
for c:=1 to 200 do Begin;
    for f:=0 to A do  Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          cou:=(f-g) and (g-f) or (f-c) or (g-c);
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}




{------------------------------------------------------------------------
---                                                                   ---
---     ROTATE PART BY VOLPONE FOR MALOREAN EFFECT TEAM  1993         ---
---                                                                   ---
------------------------------------------------------------------------}


{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ROTATE2;
BEGIN;
for f:=0 to 99 do Tx[f]:=f;
for f:=0 to 99 do Ty[f]:=f;

for c:=0 to 200  do Begin;
    for f:=1 to A do Begin;
        Tx[f]:=((Tx[f] shr 1)+((Ty[f] and 1) Shl 7));
        Ofset1_f:=Mul1[f];
        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                          Ty[g]:=((Ty[g] shr 1)+((Tx[g] and 1) Shl 7));
                          cou :=Tx[c+f]+Ty[c+g] ;

                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];

V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ROTATE5;
BEGIN;
for f:=0 to 99 do Tx[f]:=f;
for f:=0 to 99 do Ty[f]:=f;

for c:=0 to 200  do Begin;
    for f:=1 to A do Begin;
        Tx[f]:=((Tx[f] shr 1)+((Ty[f] and 1) Shl 7));
        Ofset1_f:=Mul1[f];
        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                            Ty[g]:=((Ty[g] shr 1)+((Tx[g] and 1) Shl 7));
                            cou :=Tx[abs(c-f)]+Ty[abs(c-g)] ;

                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];

V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ROTATE7;
BEGIN;
for f:=0 to 99 do Tx[f]:=f;
for f:=0 to 99 do Ty[f]:=f;

for c:=0 to 200  do Begin;
    for f:=1 to A do Begin;
        Tx[f]:=((Tx[f] shr 1)+((Ty[f] and 1) Shl 7));
        Ofset1_f:=Mul1[f];
        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
                           Ty[g]:=((Ty[g] shr 1)+((Tx[g] and 1) Shl 7));
                           cou :=Tx[c+g]+Ty[c+f] and (f+g+c);


                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];

V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ROTATE12;
BEGIN;
for f:=0 to 99 do Tx[f]:=f;
for f:=0 to 99 do Ty[f]:=f;

for c:=0 to 40  do Begin;
    for f:=1 to A do Begin;
        Ofset1_f:=Mul1[f];
        Ofset2_f:=Mul2[f];
        for g:=f to A do Begin;
        Tx[f]:=Tx[f]+ (Abs(cou+Ty[f]-Tx[g]) shr 3);
        Ty[g]:=Abs(c-Ty[g]+Tx[f]);
        cou :=Tx[f]+Ty[f];
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];

V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                          end;
                          end;
If keypressed then ModifA;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}



{------------------------------------------------------------------------
-----                                                               -----
-----     EXPOLY PART BY VOLPONE 1993 FOR MALOREAN EFFECT           -----
-----                                                               -----
------------------------------------------------------------------------}


{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ExPoly5_v16;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 280 DO   Begin

For xe:=0 to Max2 Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=1 TO Xe DO Begin;
                    P2:=Ay[Ye]*ye*ye;{+By[Ye]*ye+Cy[Ye];}
                    cou:=p1 +  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;

                    Vga_Ecran[t[100+a-Xe]+a+160-Ye]:=Cou;
                    Vga_Ecran[t[100+a-Ye]+a+160-Xe]:=Cou;
                    Vga_Ecran[t[100+a-Ye]-a+160+Xe]:=Cou;
                    Vga_Ecran[t[100+a-Xe]-a+160+Ye]:=Cou;
                    Vga_Ecran[t[100-a+Xe]-a+160+Ye]:=Cou;
                    Vga_Ecran[t[100-a+Ye]-a+160+Xe]:=Cou;
                    Vga_Ecran[t[100-a+Ye]+a+160-Xe]:=Cou;
                    Vga_Ecran[t[100-a+Xe]+a+160-Ye]:=Cou;

                   end;
                   end;

For xe:=Max2 to a Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=1 TO (a-Xe) DO Begin;
                    P2:=Ay[Ye]*ye*ye;{+By[Ye]*ye+Cy[Ye];}
                    cou:=p1 +  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;

                    Vga_Ecran[t[100+a-Xe]+a+160-Ye]:=Cou;
                    Vga_Ecran[t[100+a-Ye]+a+160-Xe]:=Cou;
                    Vga_Ecran[t[100+a-Ye]-a+160+Xe]:=Cou;
                    Vga_Ecran[t[100+a-Xe]-a+160+Ye]:=Cou;
                    Vga_Ecran[t[100-a+Xe]-a+160+Ye]:=Cou;
                    Vga_Ecran[t[100-a+Ye]-a+160+Xe]:=Cou;
                    Vga_Ecran[t[100-a+Ye]+a+160-Xe]:=Cou;
                    Vga_Ecran[t[100-a+Xe]+a+160-Ye]:=Cou;

                   end;
                   end;
If keypressed then ModifA;
                   end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY1;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 135 DO BEGIN;
For xe:=0 to A Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x;{+Cx[Xe];}
For Ye:=Xe TO A DO Begin;
                    P2:=Ay[Ye]*ye*ye+By[Ye]*ye+Cy[Ye];
                    cou:=p1 +  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY5;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 140 DO BEGIN;
For xe:=0 to A Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO A DO Begin;
                    P2:=Ay[Ye]*ye*ye;{+By[Ye]*ye+Cy[Ye];}
                    cou:=p1 +  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY6;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 200 DO begin;
For xe:=0 to A Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO A DO Begin;
                    P2:=Ay[Ye]*ye*ye+By[Ye]*ye+Cy[Ye];
                    cou:=p1 +  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY8;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 180 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 500 DO Begin;
For xe:=0 to A Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO A DO Begin;
                    P2:=Ay[Ye]*ye*ye+By[Ye]*ye+Cy[Ye];
                    cou:=p1 -  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY9;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 1000 DO  Begin;
                    Inc(x,4);
For xe:=0 to A Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO A DO Begin;
                    P2:=Ay[Ye]*ye*ye+By[Ye]*ye+Cy[Ye];
                    cou:=p1 div   p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY10;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 500 DO  Begin;
                    Inc(x);
For xe:=0 to A Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO A DO Begin;
                    P2:=Ay[Ye]*ye*ye+By[Ye]*ye+Cy[Ye];
                    cou:=p1 mod  p2;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY11;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

For x:=1 to 200 DO  Begin;
For xe:=0 to A Do  Begin;
                    P1:=Ax[Xe]*x*x+Bx[Xe]*x+Cx[Xe];
For Ye:=Xe TO A DO Begin;
                    P2:=Ay[Ye]*ye*ye+By[Ye]*ye+Cy[Ye];
                    cou:=p2  mod  p1;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE EXPOLY15;
BEGIN;
Ax[0]:=1;
Bx[0]:=2;
Cx[0]:=3;
For F:=1 to 319 Do Begin;
                   Ax[f]:=Ax[F-1];
                   Bx[f]:=2*Ax[F-1]+Bx[F-1];
                   Cx[f]:=Bx[F-1]+Cx[F-1];
                   END;
Ay[0]:=1;
By[0]:=3;
Cy[0]:=2;
For F:=1 to 199 Do Begin;
                   Ay[f]:=Ay[F-1];
                   By[f]:=2*Ay[F-1]+By[F-1];
                   Cy[f]:=By[F-1]+Cy[F-1];
                   END;

Az[0]:=1;
Bz[0]:=7;
Cz[0]:=4;
For Xe:=1 to 319 Do
For Ye:=1 to 199 do begin;

                   Az[Xe]:=2*Bx[Ye-1]+Cx[Xe];
                   Bz[Ye]:=Ax[Xe-1]-Bx[Ye];
                   Cz[Xe]:=(Az[Xe] mod 5) + 3*Bz[Xe];
                   END;



For x:=1 to 180 DO  Begin;
For xe:=1 to A Do  Begin;
For Ye:=Xe TO A DO Begin;
                    P3:=Az[Xe-Ye]*x+Bz[Ye]*x+Cz[Xe];

                    cou:=P3 div ye;
                    Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                    Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                    Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                    Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                    Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                    Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                    Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                    Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;
                   end;
                   end;
If keypressed then ModifA;
                   end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
{------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
------------------------------------------------------------------------}
Procedure SetPal;
BEGIN;

ASM;
{ La palette charge devient la palette active}

          MOV SI,Offset(Palette);

          MOV BX,0       ;{ BX =compteur de 0 a 255}

@LoadPal1: CMP BX,255
           JA  @LoadPal2    ;

          MOV DX,3C8h    ; {Port 3C8h met n° DAC Dadant}
          MOV AL,BL      ;
          OUT DX,AL      ;


          MOV DX,3C9h   { ; Port 3C8h met R puis V puis B incrementation
                         ; est gerer par le materiel                    }
          MOV AL,DS:[SI] ;{ R[BX] -> AH}
          OUT DX,AL
          INC SI

          MOV AL,DS:[SI] ;{ V[BX] -> AH}
          OUT DX,AL
          INC SI

          MOV AL,DS:[SI] ;{ B[BX] -> AH}
          OUT DX,AL
          INC SI

          INC BX         ;{ Incremente le compteur}
          JMP @LoadPAl1

@LoadPal2:

END;
END;

{************************************************************************}

Procedure IncDac127;
VAR       F        : Byte;
          PalInter : T2_Palette;
BEGIN;
IF KEYPRESSED THEN READKEY
              ELSE BEGIN;
                   Pulse:=0;
                   PalInter:=Palette;
                   For F:=1 To 127 Do Palette[f]:=PalInter[f-1];
                   Palette[1]:=PalInter[127];
                   SetPal;

                   REPEAT;
                   UNTIL PULSE=1;
                   END;
END;
{************************************************************************}
Procedure IncDac256;
VAR       F        : Byte;
          PalInter : T2_Palette;
BEGIN;
IF KEYPRESSED THEN READKEY
              ELSE BEGIN;
                   Pulse:=0;
                   PalInter:=Palette;
                   For F:=1 To 255 Do Palette[f]:=PalInter[f-1];
                   Palette[1]:=PalInter[255];
                   SetPal;

                   REPEAT;
                   UNTIL PULSE=1;
                   END;
END;

{************************************************************************}
PROCEDURE CHARGE_IM1;
VAR       F1         : Word;
VAR       P          : ObjPalette;
BEGIN;

Charge_Shoot('DATA.007');
P.GetDac(0,255,Palette);
For F1:=1 To 200 Do IncDac127;

END;

PROCEDURE CHARGE_IM2;
VAR       F1         : Word;
VAR       P          : ObjPalette;
BEGIN;

Charge_Shoot('DATA.008');
P.GetDac(0,255,Palette);
For F1:=1 To 200 Do IncDac127;
END;

PROCEDURE CHARGE_IM3;
VAR       F1         : Word;
VAR       P          : ObjPalette;
BEGIN;
Charge_Shoot('DATA.003');
P.GetDac(0,255,Palette);
For F1:=1 To 200 Do IncDac127;
END;


PROCEDURE CHARGE_IM4;
VAR       F1         : Word;
VAR       P          : ObjPalette;
BEGIN;
Charge_Shoot('DATA.004');
P.GetDac(0,255,Palette);
For F1:=1 To 200 Do IncDac127;
END;


PROCEDURE CHARGE_IM5;
VAR       F1         : Word;
VAR       P          : ObjPalette;
BEGIN;

Charge_Shoot('DATA.002');
P.GetDac(0,255,Palette);
For F1:=1 To 200 Do IncDac256;
END;


{------------------------------------------------------------------------
---                                                                   ---
---     ITER PART CODE BY VOLPONE FOR MALOREAN EFFECT TEAM  1993      ---
---                                                                   ---
------------------------------------------------------------------------}
PROCEDURE ITER1;
Var
       cc : word;
       ia,ib,ap,bp : word;
       res : word;
       nbiter: byte;

Begin;
c:=0;
for cc:=0 to 150  do Begin;
                   c:=c+1; {faire varier c 10 100 1000 change motif}
                    for f:=1 to A do Begin;
                        Ofset1_f:=Mul1[f];
                        Ofset2_f:=Mul2[f];
                    for g:=f to A do Begin;
                    ia:=f and g;
                    ib:=f-g;
                    if ib=0 then ib:=ia;
                    ap:=ia;
                    bp:=ib;
                    ia:=ap*ap+ (c*bp div 4);
                    ib:=ap div bp;
                    res:=ia + ib;

                                      cou:= res;
                          Ofset1_g:=Mul1[g];
                          Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                                      end;
                                      end;
If keypressed then ModifA;

                    end;
END;



{------------------------------------------------------------------------
---                                                                   ---
---     CONG PART CODE BY VOLPONE FOR MALOREAN EFFECT TEAM  1993      ---
---                                                                   ---
------------------------------------------------------------------------}
PROCEDURE CONG1;
Begin;
for f:=1 to 99 do BEGIN;
                  Ofset1_f:=Mul1[f];
                  Ofset2_f:=Mul2[f];
                  for g:=f to 99 do Begin;
                                    ca:=1;
                                    repeat;
                                    inc(ca);
                                    until (g mod ca =f) or (ca=250);
                                    cou:= ca ;
                                    Ofset1_g:=Mul1[g];
                                    Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                                    end;
                  end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG2;
Begin;
for f:=1 to 99 do BEGIN;
                  Ofset1_f:=Mul1[f];
                  Ofset2_f:=Mul2[f];
                  for g:=f to 99 do Begin;
                                    ca:=1;
                                    repeat;
                                    inc(ca);
                                    until (g mod f =ca) or (ca=250);
                                    cou:= ca ;
                                    Ofset1_g:=Mul1[g];
                                    Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                                    end;
                  end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG5;
Begin;
for f:=1 to 99 do BEGIN;
                  Ofset1_f:=Mul1[f];
                  Ofset2_f:=Mul2[f];
                  for g:=f to 99 do Begin;
                                    ca:=1;
                                    repeat;
                                    inc(ca);
                    until (f and  g =ca) or (ca=250);
                                    cou:= ca ;
                                    Ofset1_g:=Mul1[g];
                                    Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                                    end;
                  end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG6;
Begin;
for f:=1 to 99 do BEGIN;
                  Ofset1_f:=Mul1[f];
                  Ofset2_f:=Mul2[f];
                  for g:=f to 99 do Begin;
                                    ca:=1;
                                    repeat;
                                    inc(ca);
                                    until (f or  g =ca) or (ca=250);
                                    cou:= ca ;
                                    Ofset1_g:=Mul1[g];
                                    Ofset2_g:=Mul2[g];
V[Ofset1_g+f]:=Cou;V[Ofset1_f+g]:=cou;V[Ofset2_g+f]:=Cou;V[Ofset2_f+g]:=Cou;
V[Ofset2_g-f]:=Cou;V[Ofset2_f-g]:=cou;V[Ofset1_g-f]:=Cou;V[Ofset1_f-g]:=Cou;
                                    end;
                  end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG8;
Begin;
for f:=1 to 240 do
                for g:=0 to 199 do Begin;
                                   ca:=1;
                                   repeat;
                                   inc(ca);
                                   until (f or  g =ca) or (ca=250);
                                   Vga_Ecran[t[g]+f]:=Ca;
                                   end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG9;
Begin;
for f:=1 to 240 do
                for g:=0 to 199 do Begin;
                                   ca:=1;
                                   repeat;
                                   inc(ca);
                                   until (f xor  g =ca) or (ca=250);
                                   Vga_Ecran[t[g]+f]:=Ca;
                                   end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG10;
Begin;
for f:=1 to 320 do
                for g:=0 to 199 do Begin;
                                   ca:=1;
                                   repeat;
                                   inc(ca);
                                   until (f and  ca =g) or (ca=250);
                                   Vga_Ecran[t[g]+f]:=Ca;
                                   end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG11;
Begin;
for f:=1 to 240 do
                for g:=0 to 199 do Begin;
                                   ca:=1;
                                   repeat;
                                   inc(ca);
                                   until (f and g=ca xor f) or (ca=250);
                                   Vga_Ecran[t[g]+f]:=Ca;
                                   end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG12;
Begin;
for f:=1 to 320 do
                for g:=0 to 199 do Begin;
                                   ca:=1;
                                   repeat;
                                   inc(ca);
                                   until (f-g=ca xor f) or (ca=250);
                                   Vga_Ecran[t[g]+f]:=Ca;
                                   end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG13;
Begin;
for f:=1 to 320 do
                for g:=0 to 199 do Begin;
                                   ca:=1;
                                   repeat;
                                   inc(ca);
                                   until (f-g=ca xor g) or (ca=250);
                                   Vga_Ecran[t[g]+f]:=Ca;
                                   end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE CONG14;
Begin;
for f:=1 to 319 do
                for g:=0 to 199 do Begin;
                                   ca:=1;
                                   repeat;
                                   inc(ca);
                                   until (f-(g and ca)=ca  ) or (ca=250);
                                   Vga_Ecran[t[g]+f]:=Ca;
                                   end;
end;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}



{------------------------------------------------------------------------
---                                                                   ---
---     ES PART CODE BY VOLPONE FOR MALOREAN EFFECT TEAM  1993        ---
---                                                                   ---
------------------------------------------------------------------------}
PROCEDURE ES2;
BEGIN;
Amin:= -10;
Amax:=  10;
Bmin:= -10;
Bmax:=  10;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 159 Do Begin;
                    PartieA:=SinX[Xe];
                    PartieB:=Px[Xe];
For Ye:=0 to 99 do Begin;
                    Cou:=Round((PartieB+Py[Ye])*PartieA);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    Cou:=Round((-Px[Xe]+Py[Ye])*PartieA);
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    Cou:=Round((Px[Xe]-Py[Ye])*PartieA);
                    VGA_Ecran[T[199-Ye]+Xe]:=Cou;
                    Cou:=Round(-(Px[Xe]+Py[Ye])*PartieA);
                    VGA_Ecran[T[199-Ye]+319-Xe]:=Cou

                    End;
                    End;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES3;
BEGIN;
Amin:= -10;
Amax:=  10;
Bmin:= -10;
Bmax:=  10;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 159 Do Begin;
                    PartieA:=Px[Xe]*SinX[Xe];
For Ye:=0 to 99 do Begin;
                    PartieB:=Py[Ye]*CosY[Ye];
                    Cou:=Round(PartieA+PartieB)*2;
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    Vga_Ecran[T[Ye]+319-Xe]:=Cou;
                    Cou:=Round(PartieA-PartieB)*2;
                    VGA_Ecran[T[198-Ye]+Xe]:=Cou;
                    Vga_Ecran[T[198-Ye]+319-Xe]:=Cou;
                    End;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES4;
BEGIN;
Amin:= -10;
Amax:=  10;
Bmin:= -10;
Bmax:=  10;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 159 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 99 do Begin;
                    PartieB:=PartieA*Py[Ye];
                    Cou:=Round(Px[Xe]+PartieB+CosY[Ye]);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    Cou:=Round(Px[Xe]-PartieB+CosY[Ye]);
                    VGA_Ecran[T[199-Ye]+Xe]:=Cou;
                    Cou:=Round(-Px[Xe]-PartieB+CosY[Ye]);
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    Cou:=Round(-Px[Xe]+PartieB+CosY[Ye]);
                    VGA_Ecran[T[199-Ye]+319-Xe]:=Cou;
                    End;
                    End;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES5;
BEGIN;
Amin:= -10;
Amax:=  10;
Bmin:= -10;
Bmax:=  10;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 159 Do Begin;
For Ye:=0 to 99  Do Begin;
                    PartieA:=SinX[Xe]*Py[Ye]*CosY[Ye];

                    Cou:=Round(Px[Xe]+PartieA);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;

                    Cou:=Round(Px[Xe]-PartieA);
                    VGA_Ecran[T[199-Ye]+Xe]:=Cou;

                    Cou:=Round(-Px[Xe]-PartieA);
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;

                    Cou:=Round(-Px[Xe]+PartieA);
                    VGA_Ecran[T[199-Ye]+319-Xe]:=Cou;

                    End;
                    End;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES6;
BEGIN;
Amin:= -10;
Amax:=  10;
Bmin:= -10;
Bmax:=  10;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 159 Do Begin;
                    PartieA:=Px[Xe]*SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=PartieA*Py[Ye]*CosY[Ye];
                    Cou:=Round(PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    Cou:=255-Cou;
                    VGA_Ecran[T[199-Ye]+Xe]:=Cou;
                    VGA_Ecran[T[199-Ye]+319-Xe]:=Cou;
                    End;
                    End;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES7;
BEGIN;
Amin:= -10;
Amax:=  10;
Bmin:= -10;
Bmax:=  10;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 319 Do Begin;
For Ye:=0 to 199 do Begin;
                    Cou:=Round(Px[Ye]*SinX[Xe]+Py[Ye]*SinX[Ye]);
                    VGA_Ecran[T[Ye]+Xe]:=Cou
                    End;
                    End;


END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES15;
BEGIN;
Amin:= -8;
Amax:=  8;
Bmin:= -8;
Bmax:=  8;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe])*( exp(Px[Xe]) + exp(-Px[Xe]) );
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye])*( exp(Py[ye]) - exp(-Py[ye]) );


For Xe:=0 to 319 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    End;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES16;
BEGIN;
Amin:= -15;
Amax:=  15;
Bmin:= -15;
Bmax:=  15;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=25*(Sin(Px[Xe])+(cos(2*Px[Xe])  ));
For ye:=0 to 199 do CosY [ye]:=25*(Cos(Py[Ye])+(sin(2*PY[Ye]) ));


For Xe:=0 to 319 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    End;
                    end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES17;
BEGIN;
Amin:= -15;
Amax:=  15;
Bmin:= -15;
Bmax:=  15;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=25*(Sin(Px[Xe])+(cos(-Px[Xe])  ));
For ye:=0 to 199 do CosY [ye]:=25*(Cos(Py[Ye])+(sin(-PY[Ye]) ));


For Xe:=0 to 319 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    End;
                    end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES20;
BEGIN;
Amin:= -25;
Amax:=  5;
Bmin:= -4;
Bmax:=  0;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=25*(Sin(Px[Xe])+(exp(Px[Xe])  ));
For ye:=0 to 199 do CosY [ye]:=25*(Cos(Py[Ye])+((PY[Ye]*py[ye]+3*py[ye]) ));


For Xe:=0 to 319 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 99 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA+PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[199-Ye]+Xe]:=Cou;
                    End;
                    end;
END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES23;
BEGIN;
Amin:= -25;
Amax:=  25;
Bmin:= -25;
Bmax:=  30;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=100*Ln(abs(Px[xe])+1);
For ye:=0 to 199 do CosY [ye]:=100*Exp(Py[Ye]/8);


For Xe:=0 to 159 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA) + round(PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    End;
                    end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES24;
BEGIN;
Amin:= -25;
Amax:=  25;
Bmin:= -25;
Bmax:=  30;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=100*Ln(abs(Px[xe])+1);
For ye:=0 to 199 do CosY [ye]:=100*Exp(Py[Ye]/8);


For Xe:=0 to 159 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA) and round(PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    End;
                    end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES25;
BEGIN;
Amin:= -25;
Amax:=  25;
Bmin:= -25;
Bmax:=  30;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=100*Ln(abs(Px[xe])+1);
For ye:=0 to 199 do CosY [ye]:=100*Exp(Py[Ye]/8);


For Xe:=0 to 159 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA) or round(PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    End;
                    end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES26;
BEGIN;
Amin:= -25;
Amax:=  25;
Bmin:= -25;
Bmax:=  30;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=100*Ln(abs(Px[xe])+1);
For ye:=0 to 199 do CosY [ye]:=100*Exp(Py[Ye]/8);


For Xe:=0 to 159 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA) xor round(PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou;
                    End;
                    end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES27;
BEGIN;
Amin:= -25;
Amax:=  0;
Bmin:= -25;
Bmax:=  0;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=100*Ln(abs(Px[xe])+1);
For ye:=0 to 199 do CosY [ye]:=100*Exp(Py[Ye]/8);


For Xe:=0 to 319 Do Begin;
                    PartieA:=SinX[Xe];
For Ye:=0 to 199 do Begin;
                    PartieB:=CosY[Ye];
                    Cou:=Round(PartieA) xor round(PartieB);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;



                    End;
                    end;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE ES30;
BEGIN;
Amin:= -25;
Amax:=  25;
Bmin:= -25;
Bmax:=  25;
pasX:=(Amax-Amin)/320;
pasY:=(Bmax-Bmin)/199;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);
For xe:=0 to 319 do SinX [xe]:=Sin(Px[Xe]);
For ye:=0 to 199 do CosY [ye]:=Cos(Py[Ye]);


For Xe:=0 to 159 Do
For Ye:=0 to 199 do Begin;
                    Cou:=Round(Px[Xe]*SinX[Xe]+Py[Ye]+COSY[Ye]);
                    VGA_Ecran[T[Ye]+Xe]:=Cou;
                    VGA_Ecran[T[Ye]+319-Xe]:=Cou
                    End;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
PROCEDURE DEMO_NORMALE;
VAR Merde       :  Byte;
    Vga         :  TGraphVga;
    Palette     : ObjPalette;
    Pale         :  T2_Palette;

Begin;
SpeedClavier( (3 shl 5) + 31 );
TEXTBACKGROUND(0);
TEXTCOLOR(7);
CLRSCR;
LitMod;

REPEAT;
CHARGE_ALL_PALETTES;
A:=CONFIG.ARETE;
Max2:=A div 2;
Vga.GraphMode;

Charge_Shoot ('DATA.006');

Pulse:=0; Repeat; Until Pulse=100;
For f:=0 to 199 do Mul1[f]:=(f+100)*320+160; For f:=0 to 199 do Mul2[f]:=(-f+100)*320+160;
Cls;
Pal (Volcano);  Carle0;
Pal (Blue   );  Carle1;
Pal (Volcano);  Carle2;  Carle3;
Pal (Blue   );  Carle5;
Pal (Volcano);  Carle8;
Pal (Blue   );  Carle12;  Carle13;  Carle14;  Carle15;  Carle16;  Carle17;
                Carle18;  Carle19;  Carle20;
Pal (Volcano);  Carle21;  Carle24;  Carle25;  Carle26;  Carle27;  Carle28;
                Carle30;  Carle33;
Pal (Blue);     Carle39;  Carle41;   Carle42;
Pal (Volcano);  Carle46;  Carle47;

CHARGE_IM2;

CLS; Pal (Volcano);  Rotate5;  Rotate7;  Rotate12;

CHARGE_IM3;
PULSE:=0;REPEAT;UNTIL PULSE=40;

CLS;Pal (Blue);  ExPoly5_v16; ExPoly1;  ExPoly5;  ExPoly6;  ExPoly8;  ExPoly9;
                 ExPoly10;    ExPoly11; ExPoly15;

PULSE:=0;REPEAT;UNTIL PULSE=40;
CHARGE_IM4;
PULSE:=0;REPEAT;UNTIL PULSE=40;

CLS; Pal (Blue);             ITER1;

PULSE:=0;REPEAT;UNTIL PULSE=40;
CHARGE_IM1;
PULSE:=0;REPEAT;UNTIL PULSE=40;

CLS; pal (pal1);   Cong1;  Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong2;  Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong5;  Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong6;  Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong8;  Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong9;  Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong10; Pulse:=0; Repeat;  until pulse=80;
CLS; pal (pal4);   Cong11; Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong12; Pulse:=0; Repeat;  until pulse=80;
CLS;               Cong13; Pulse:=0; Repeat;  until pulse=80;
CLS; pal (pal2);   Cong14; Pulse:=0; Repeat;  until pulse=80;

PULSE:=0;REPEAT;UNTIL PULSE=40;
CHARGE_IM5;
PULSE:=0;REPEAT;UNTIL PULSE=40;

CLS; Pal(Default); Es2;    Pulse:=0; Repeat;  until pulse=80;
CLS; Pal(Pal1);    Es3;    Pulse:=0; Repeat;  until pulse=80;
CLS;               Es4;    Pulse:=0; Repeat;  until pulse=80;
CLS;               Es5;    Pulse:=0; Repeat;  until pulse=80;
CLS;               Es6;    Pulse:=0; Repeat;  until pulse=80;
CLS;               Es7;    Pulse:=0; Repeat;  until pulse=80;
CLS; Pal(blue);    Es15;   Pulse:=0; Repeat;  until pulse=80;

CLS; Pal(pal4);    Es16;   Pulse:=0; Repeat;  until pulse=80;
CLS;               Es17;   Pulse:=0; Repeat;  until pulse=80;
CLS;               Es20;   Pulse:=0; Repeat;  until pulse=80;
CLS;               Es23;   Pulse:=0; Repeat;  until pulse=80;
CLS;               Es24;   Pulse:=0; Repeat;  until pulse=80;
CLS;               Es25;   Pulse:=0; Repeat;  until pulse=80;
CLS;               Es26;   Pulse:=0; Repeat;  until pulse=80;
CLS;               Es27;   Pulse:=0; Repeat;  until pulse=80;

CLS; Pal(pal1);    Es30;   Pulse:=0; Repeat;  until pulse=80;


CONFIG.ARETE:=A;
VGA.TextMode;

UNTIL CONFIG.PERPETUEL=FALSE;
For f:=1 to 64 do begin;
                  modvolume (255-4*f,255-4*f,255-4*f,255-4*f);
                  Pulse:=0;
                  Repeat;
                  until pulse=1;
                  end;
MODSTOP;

END;
{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}






{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░}
Begin;
CheckBreak:=FALSE;
TEXTBACKGROUND(0);
CLRSCR;


DEMO_NORMALE;
SpeedClavier( (0 shl 5) + 5);

END.
