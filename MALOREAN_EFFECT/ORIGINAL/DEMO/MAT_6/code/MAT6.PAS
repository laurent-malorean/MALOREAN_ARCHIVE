{ þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                      þ
; þ                       DEMO MATHEMATICA 5                             þ
; þ                                                                      þ
; þ                      1993 MALOREAN EFFECT                            þ
; þ                                                                      þ
; þ     CREDIT POUR LA DEMO :  Volpone : CODE                            þ
; þ                            Toto    : Idees sur la manipulation des   þ
; þ                                         quartiques                   þ
; þ                                                                      þ
; þ       RELEASE : Decembre 1993                                        þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}

USES GEST_GRAPH,DAC_CODE,DAC_TOTO,DAC_FRAC,CRT,CSCREEN,VARIABLE,ECRAN;

{$M $4000,0,0} 			{16k stack, no heap - adjust as needed }
{$L MOD-obj.OBJ} 	        { Link in Object file }


{$F+} 				{ force calls to be 'far'}
procedure modvolume(v1,v2,v3,v4:integer); external ; {Can do while playing}
procedure moddevice(var device:integer); external ;
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); external ;
procedure modstop; external ;
procedure modinit; external;
{$F-}

VAR    {Variables pour le tracker}
       dev,mix,stat,pro,loop : integer;
       md : string;
       ch: char;

{-------------------------------------------------------------------}
{ pour la partie variation de palette}
type      TColor   = Record
                     R,V,B : Byte;
                     end;
          T2_Palette = Array[0..255] of TColor;

VAR       PalInter :t2_Palette;
          Pal1     :T2_Palette;

g : word;
var f: byte;
var segpal1,ofspal1 : word;

PROCEDURE LitMod ;
PROCEDURE UTIL1;
BEGIN;    Md:=('redhouse.mod');
          If dev=0 then mix := 11000;   {use 10000 normally }
          If dev<>0 then mix:= 11000;   {use 10000 normally }

          pro := 0; {Leave at 0}
          loop :=4; {4 means mod will play forever}
          modvolume (255,255,255,255);    { Full volume }
	  modsetup ( stat, dev, mix, pro, loop, md );
END;

BEGIN;    modinit;
	  moddevice ( dev ); { Returns device number in DEV or 255 if 'no sound' }
          if (dev =255) then Else UTIL1;
END;

{---------------------------------------------------------------------------}
Procedure IncDac256 (nbpulse : byte);

BEGIN;
  Pulse:=0;
  PalInter:=Pal1;
  For F:=1 To 255 Do Pal1[f]:=PalInter[f-1];
  Pal1[1]:=PalInter[255];
while keypressed do readkey;
ASM;
{ La palette charge devient la palette active}
          mov ax,segpal1;
          mov ds,ax;
          MOV SI,ofspal1;

          MOV BX,0       ;{ BX =compteur de 0 a 255}

@LoadPal1: CMP BX,255
           JA  @LoadPal2    ;

          MOV DX,3C8h    ; {Port 3C8h met nø DAC Dadant}
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
repeat; until pulse>=NbPulse;
END;
{----------------------------------------------------------------------}
{------------------------------------------------------------------------}



{------------------------------------------------------------------------}

{************************************************************************}
PROCEDURE marc_3;
Var    X        : word;
       Y        : word;
       cou      : Byte;

Begin;
Put_Dac(dac_frac.Pal4);
for X:=1 to 319 do
for Y:=1 to 199 do Begin;
                  cou:=X*X and y*y;
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
delay(2500);
END;
{************************************************************************}
PROCEDURE MARC_7;
Var    X,Y,Z    : word;
       cou      : Byte;
       Carre    : Array[1..500] Of Word;
Begin;
Put_Dac(dac_frac.Pal4);
for X:=0 to 500 do Carre[X]:=X*X;

for Z:=1 to 199 do
for X:=1 to 199 do
for Y:=1 to 199 do Begin;
                  cou:=Carre[((X-Z) or (Y+Z))];
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
delay(2500);
END;
{************************************************************************}
PROCEDURE MARC_8;
Var    X,Y,Z    : word;
       cou      : Byte;
Begin;
Put_Dac(dac_frac.Pal4);

for Z:=1 to 201 do Begin;
                   Inc(z,2);
for X:=1 to 199 do
for Y:=1 to 199 do Begin;
                  cou:=Z*((X-Z) or (Y+Z)) div 20;
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
                  end;
delay(2000);
END;
{************************************************************************}
PROCEDURE MARC_9;
Var    X,Y,Z    : word;
       cou      : Byte;
Begin;
Put_Dac(dac_frac.Pal4);

for Z:=1 to 060 do
for X:=1 to 319 do
for Y:=1 to 199 do Begin;
                  cou:=((x+z) and (y+z)) xor (x or Y);
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
END;
{************************************************************************}
PROCEDURE MARC_10;
Var    X,Y,Z    : word;
       cou      : Byte;
       Carre    : Array[0..400] Of Word;
       Cst1     : Word;
       Ofset    : Word;


BEGIN;
Put_Dac(dac_frac.Pal4);
for Z:=1 to 350 do Carre[Z]:=Z*Z;

for Z:=1 to 600 do Begin
                   z:=z+3;
asm;
mov  dx,03DAh
@StandVBL1:  IN   al,dx
	     test al,8
	     jz   @StandVBL1
end;

for Y:=1 to 150 do Begin
                   Cst1:=Carre[z]+Carre[y]-y;
                   Ofset:=Mul320[Y];
for X:=1 to 150 do Begin
                  Vga[Ofset+X]:=(Cst1+Carre[x]+x) div (x+y+1);
                  end;
                  end;
                  end;
delay(2000);
END;
{************************************************************************}


BEGIN
segpal1:=seg(Pal1);
ofspal1:=ofs(pal1);

CLRSCR;

LITMOD;

GraphMode;

loadShoot('data.005');
PULSE:=0; REPEAT; UNTIL PULSE=100;


loadShoot('data.000'); DELAY (4000);
MARC_3;

loadShoot('data.001'); Delay(4000);

{ ******************************** }{MARC_7;}{************************}



move(dac_frac.pal4,pal1,3*256);
loadShoot('data.002'); Delay(2800);
for g:=0 to 100 do  IncDac256(1);
for g:=0 to 40  do Begin; IncDac256(0); IncDac256(1);              end;
for g:=0 to 80  do Begin; IncDac256(0); IncDac256(1);IncDac256(0); end;
for g:=0 to 80  do Begin; IncDac256(0); IncDac256(0); IncDac256(1);IncDac256(0);IncDac256(0); end;

{*****************************}{Marc_8;}{****************************}

move(dac_frac.pal4,pal1,3*256);
loadShoot('data.003'); Delay(3000);
MARC_10;

move(dac_frac.pal4,pal1,3*256);
loadShoot('data.004'); Delay(2800);
for g:=0 to 100 do  IncDac256(1);
for g:=0 to 40  do Begin; IncDac256(0); IncDac256(1);              end;
for g:=0 to 80  do Begin; IncDac256(0); IncDac256(1);IncDac256(0); end;
for g:=0 to 80  do Begin; IncDac256(0); IncDac256(0); IncDac256(1);IncDac256(0);IncDac256(0); end;
MARC_9;

loadShoot('data.006');
PULSE:=0; REPEAT; UNTIL PULSE=250;
TEXTMODE(1);
Clrscr;
MODSTOP;

END.