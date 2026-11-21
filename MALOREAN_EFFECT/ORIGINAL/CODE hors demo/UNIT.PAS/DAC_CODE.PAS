{  ╔════════════════════════════════════════════════════════════════════╗
   ║                                                                    ║
   ║                            UNIT GEST_DAC                           ║
   ║                                                                    ║
   ║                   For DAC uses with 13h Graph Mode                 ║
   ║                                                                    ║
   ║                 Coding By Volpone Of Malorean Effect               ║
   ║                                                                    ║
   ║                      Version 1 : September 1993                    ║
   ║                                                                    ║
   ║                                                                    ║
   ║ If you uses this do credit or thanks Volpone of Malorean Effect    ║
   ║                                                                    ║
   ╚════════════════════════════════════════════════════════════════════╝ }




UNIT DAC_CODE;

INTERFACE

USES DOS,CRT,VARIABLE;

TYPE TPAL    = ARRAY[1..256*3] OF BYTE ;



CONST  MaxDac    = 256*3            ;
CONST  NBColor   = 62               ;
VAR    Palette   : TPal             ;
VAR    PalSauve  : TPal             ;

PROCEDURE PUT_DAC (NAME   : TPAL)   ;
PROCEDURE GET_DAC (Var NAME   : TPAL)   ;
PROCEDURE INC_DAC                   ;
PROCEDURE DEC_DAC                   ;
PROCEDURE Dac2Black                 ;
PROCEDURE Dac2Color                 ;
PROCEDURE DacBlack                  ;
PROCEDURE DacColor                  ;


IMPLEMENTATION
{------------------------------------------------------------------------}
PROCEDURE PUT_DAC   (NAME   : TPAL);
VAR       Reg     :  Registers;
BEGIN;    Palette := Name;
          Reg.AX  := $1012;
          Reg.BX  := 0;
          Reg.CX  := 255;
          Reg.ES  := Seg(NAME);
          Reg.DX  := Ofs(NAME);
          INTR($10,Reg);
END;
{------------------------------------------------------------------------}
PROCEDURE GET_DAC;
VAR       Reg : Registers;
BEGIN;    Reg.AX:=$1017;
          Reg.BX:=0;
          Reg.CX:=255;
          Reg.ES:=Seg(Name);
          Reg.DX:=Ofs(Name);;
          intr($10,Reg);
END;
{------------------------------------------------------------------------}
Procedure Inc_DAC;
VAR       F        : WORD;
          PalInter : TPal;
BEGIN;
PalInter:=Palette;
For F:=1 To MaxDAc-3 Do Palette[f]:=PalInter[f-1];
Palette[1]:=PalInter[255];
PUT_DAC(Palette);
END;

Procedure DEC_DAC;
VAR       F        : Byte;
          PalInter : TPal;
BEGIN;    PalInter:=Palette;
          For F:=0 To 254 Do Palette[f]:=PalInter[f+1];
          Palette[255]:=PalInter[1];
          PUT_DAC(Palette);
END;
{------------------------------------------------------------------------}
PROCEDURE DAC2BLACK;
VAR       IDac : WORD;
VAR       F255 : BYTE;
BEGIN;    PalSauve:=Palette;
          For F255:=0 To 255 Do Begin;
                                PULSE:=0;
                                For IDac:=1 To MaxDac Do
                                If Palette[IDac]>1 THen Dec(Palette[IDac]);
                                REPEAT;
                                UNTIL PULSE>1;
                                PUT_DAC(Palette);
                                End;
END;
{------------------------------------------------------------------------}
PROCEDURE Dac2Color;
VAR       IDac : WORD;
VAR       F255 : BYTE;
BEGIN;    For F255:=0 To 63 Do Begin;
                               PULSE:=0;
                               For IDac:=1 To MaxDac Do
                               If Palette[IDac]<PalSauve[IDac] Then
                               Inc(Palette[IDac]);
                               REPEAT;
                               UNTIL PULSE>1;
                               PUT_DAC(Palette);
                               End;
END;
{------------------------------------------------------------------------}
PROCEDURE DacColor;
VAR       IDac : WORD;
VAR       F255 : BYTE;
BEGIN;    Palette:=PalSauve;
          PUT_DAC(Palette);
END;
{------------------------------------------------------------------------}
PROCEDURE DacBlack;
VAR       IDac : WORD;
VAR       F255 : BYTE;
BEGIN;    PalsAUVE:=Palette;
          For IDac:=0 To MaxDac Do Palette[IDac]:=0;
          PUT_DAC(Palette);
END;
{------------------------------------------------------------------------}


BEGIN;
END.
