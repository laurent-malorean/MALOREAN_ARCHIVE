{         ษอออออออออออออออออออออออออออออออออออออออออออออออป
          บ                                               บ
          บ             UNIT GEST_GRAPH                   บ
          บ                                               บ
          บ    For uses 320*200 256 Colors 1 bit-plane    บ
          บ                                               บ
          บ    Coding By Volpone Of Malorean Effect       บ
          บ                                               บ
          บ       Version 1 : September 1993              บ
          บ                                               บ
          บ    If you uses this do credit or thanks me    บ
          บ                                               บ
          ศอออออออออออออออออออออออออออออออออออออออออออออออผ }

UNIT GEST_GRAPH;

INTERFACE

USES    DAC_code;

TYPE    T_VGA = ARRAY [0..63999] OF BYTE;

VAR     VGA      : T_VGA  ABSOLUTE $A000:$0000; {The Vga's Screen}
        VGA_WORD  : ARRAY [0..32000] OF WORD  ABSOLUTE $A000:$0000;
        VGA_CENTRE: ARRAY [0..63999] OF Byte  ABSOLUTE $A000:32160;

        MUL320         : array [0..199] of Word; {For Ofset=y*320+Y}
        F_MUL320       : BYTE;

PROCEDURE PutPixel      (X,Y           : Word;
                         Couleur       : Byte  );
{Put A pixel in (X,Y) , Couleur=Color of the pixel}

PROCEDURE Droite        (X1,Y1,X2,Y2,C : Integer  );
{Put A Line With Bressanam algorithm
Pixel Start (X1,Y1) \ Pixel End (X2,Y2) Color=Color of the line}

PROCEDURE CLS           (COLOR         : BYTE  );
{Clear Screen  Color=Color Background}

FUNCTION  GetPixel      (X,Y           : Word  ) : Byte ;
{Return pixel's color in coordonate (X,Y) }

PROCEDURE GraphMode;
{Togle In Graphe Mode}

PROCEDURE TextMode;
{Togle In Text Mode}

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
BEGIN;    VGA[MUL320[Y]+X]:=COULEUR;
END;
{--------------------------------------------------------------------------}
FUNCTION GetPixel;
 BEGIN;   GetPixel:=VGA[MUL320[Y]+X];
END;
{--------------------------------------------------------------------------}
PROCEDURE DROITE  ;
VAR Dx,Dy        : Integer;
    Dx2,Dy2      : Integer;
    S1,S2        : ShortInt;
    X,Y          : Integer;
    Erreur       : Integer;
    Temp         : Integer;
    InterChange  : Integer;
    F            : Integer;

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
                  IF (x>0) and (x<320) and (y>0) and (y<200) then Vga[mul320[y]+x]:=Vga[mul320[y]+x]+c;
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
TYPE       Type_Sous_Buffer = Array [1..6400] of Byte;
TYPE       TYPE_buffer      = ARRAY [1..10]   of TYPE_SOUS_BUFFER;

Var        Merde       :  Byte;
           Fichier     :  FILE;
           Pal         :  TPal;
           Buffer      :  ^TYPE_SOUS_BUFFER;
BEGIN;     New(BUFFER);               {initialise le buffer}

           Assign(Fichier,nom);
           Reset(Fichier, 1);
           BlockRead(Fichier,Merde,1);
           BlockRead(Fichier,Pal,768);
           BlockRead(Fichier,VGA,64000);
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
  BlockWrite(Fichier,Vga,SizeOf(VGA));
  Close(Fichier);
end;
{--------------------------------------------------------------------------}


{--------------------------------------------------------------------------}
BEGIN;
FOR F_MUL320:=0 TO 199 DO MUL320[F_MUL320]:=F_MUL320*320;
{Initialise y*320 table}
END.