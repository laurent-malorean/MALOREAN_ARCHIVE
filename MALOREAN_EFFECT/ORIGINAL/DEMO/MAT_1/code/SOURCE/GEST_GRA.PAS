{ þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                      þ
; þ                          UNIT GEST_GRAPH                             þ
; þ                            VERSION 1                                 þ
; þ                                                                      þ
; þ                      1993 MALOREAN EFFECT                            þ
; þ                     RELEASE: SEPTEMBER 1993                          þ
; þ                                                                      þ
; þ                        CODE BY VOLPONE                               þ
; þ                                                                      þ
; þ        IF YOU USE THIS DO CREDIT VOLPONE of Malorean Effect          þ
; þ                                                                      þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}

UNIT GEST_GRAPH;


INTERFACE
USES GEST_DAC;

TYPE T_VGA = ARRAY [0..63999] OF BYTE;

VAR     VGA_ECRAN      : T_VGA  ABSOLUTE $A000:$0000;
        VGA_ECRAN_WORD : ARRAY [0..32000] OF WORD  ABSOLUTE $A000:$0000;
        MUL320         : array [0..199] of Word;
        F_MUL320       : BYTE;

PROCEDURE PutPixel      (X,Y           : Word;
                         Couleur       : Byte  );
PROCEDURE Droite        (X1,Y1,X2,Y2,C : WORD  );
PROCEDURE CLS           (COLOR         : BYTE  );
FUNCTION  GetPixel      (X,Y           : Word  ) : Byte ;
PROCEDURE GraphMode;
PROCEDURE TextMode;
PROCEDURE LoadShoot (NOM : STRING);
PROCEDURE SaveShoot (NOM : STRING);

{**************************************************************************}
{**************************************************************************}
{**************************************************************************}
{**************************************************************************}

IMPLEMENTATION

PROCEDURE GraphMode; ASSEMBLER;
ASM       MOV AX,$13;
          INT $10;
END;
{--------------------------------------------------------------------------}
PROCEDURE TextMode; ASSEMBLER;
ASM       MOV AX,$03;
          INT $10;
END;
{--------------------------------------------------------------------------}
PROCEDURE Putpixel;
BEGIN;    VGA_ECRAN[MUL320[Y]+X]:=COULEUR;
END;
{--------------------------------------------------------------------------}
FUNCTION GetPixel;
BEGIN;   GetPixel:=VGA_ECRAN[MUL320[Y]+X];
END;
{--------------------------------------------------------------------------}
PROCEDURE DROITE  ;
VAR Dx,Dy        : Byte;
    Dx2,Dy2      : Byte;
    S1,S2        : ShortInt;
    X,Y          : Byte;
    Erreur       : Integer;
    Temp         : Byte;
    InterChange  : Byte;
    F            : Byte;

BEGIN;
X:=X1;
Y:=Y1;

Dx:=Abs(X2-X1);
Dy:=Abs(Y2-Y1);

If X2-X1=0 Then S1:=0;
If X2-X1>0 Then S1:=1;
If X2-X1<0 Then S1:=-1;

If Y2-Y1=0 Then S2:=0;
If Y2-Y1>0 Then S2:=1;
If Y2-Y1<0 Then S2:=-1;

If Dy>Dx Then Begin;
              Temp        := Dx;
              Dx          := Dy;
              Dy          := Temp;
              InterChange := 1;
              End
              Else InterChange :=0;

Dx2:=Dx Shl 1;
Dy2:=Dy Shl 1;

Erreur:=Dy2 -Dx;

For F:=1 To Dx Do Begin;
                  Putpixel (x,y,c);
                  While Erreur>=0 Do Begin;
                                     If InterChange=1 Then Inc(X,S1)
                                                      Else Inc(Y,S2);
                                     dec(Erreur,Dx2);
                                     End;
                  If InterChange=1 Then Inc(Y,S2)
                                   Else Inc(X,S1);
                  Inc(Erreur,Dy2);
                  End;

END;
{--------------------------------------------------------------------------}
PROCEDURE Cls ; ASSEMBLER;
ASM;
       MOV  AX,$A000
       MOV  ES,AX
       MOV  DI,0

       MOV  AL,Color
       MOV  AH,Color

@Cls1: CMP  DI,64000
       JA   @Cls2
       MOV  ES:[DI],AX
       ADD  DI,2
       JMP  @Cls1

@Cls2:
END;
{**************************************************************************}
{**************************************************************************}
{**************************************************************************}
{**************************************************************************}
PROCEDURE  LoadShoot;
Var        Merde       :  Byte;
           Fichier     :  FILE;
           Pal         :  TPal;
BEGIN;     Assign(Fichier,nom);
           Reset(Fichier, 1);
           BlockRead(Fichier,Merde,1);
           BlockRead(Fichier,Pal,768);
           BlockRead(Fichier,VGa_Ecran,64000);
           Close(Fichier);
           PUT_DAC(PAL);
END;
{--------------------------------------------------------------------------}
PROCEDURE SaveShoot;
Var Merde       :  Byte;
    Fichier     :  FILE;
    Palette     :  TPal;

Begin;
  GET_DAC (Palette);
  Assign(Fichier,nom);
  Rewrite(Fichier,1);
  BlockWrite(Fichier,Merde,SizeOf(Merde));
  BlockWrite(Fichier,Palette,SizeOf(Palette));
  BlockWrite(Fichier,Vga_Ecran,SizeOf(VGa_Ecran));
  Close(Fichier);
end;
{--------------------------------------------------------------------------}


{--------------------------------------------------------------------------}
BEGIN;
FOR F_MUL320:=0 TO 199 DO MUL320[F_MUL320]:=F_MUL320*320;
END.