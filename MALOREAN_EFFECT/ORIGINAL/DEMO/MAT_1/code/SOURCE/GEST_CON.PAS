{---------- Unit‚ de configuration en objet (C) C‚dric Pulrulczyk ----------}
Unit Gest_Configuration;

INTERFACE
{----------------------------------------------------------------------------}
Const Ecran:Array[1..9] of string[30]=('Pas de carte','MDA','CGA',
                                        'EGA','EGA Mono','VGA Mono','VGA Couleur','Carte inconnue','.');
    Systeme:Array[1..4] of string[10]=('MS-DOS','OS','WINDOWS','.');
 Processeur:Array[1..11] of string[15]=('Intel 8088',
                                    'Intel 8086',
                                    'Nec V20   ',
                                    'Nec V30   ',
                                    'Intel 80188',
                                    'Intel 80186',
                                    'Intel 80286',
                                    'Intel 80386',
                                    'Intel 80486',
                                    'Pentium',
                                    '.');
Coprocesseur:Array [1..4] of String[20]= ( 'Pas de coprocesseur',
                                           '8087',
                                           '80287',
                                           'i387/i487');

  Reseau :Array[1..3] of string[20]=('Non install‚','Install‚','.');
  Langue :Array[1..9] of string[20]=('Fran‡ais','Italiano','English','Dansk',
                                'Deustch','Portuguˆs','Espa¤ol','Nederlands','.');

 Pointeur:Array[1..6] of string[20]=('Aucun','Souris','Joystick','Stylo','Table tra‡ante','.');
      Son:Array[1..7] of string[30]=('Aucun','AdLib','Sound Blaster Pro','Sound Blaster Pro II',
                                  'Covox Speech Thing','Disney Sound','.');

 Var Imprimante:Array[1..50] of string[20];
 Var VMemoire,VEcran,VSysteme,VProcesseur,VCoprocesseur,VReseau,VLangue,VPointeur,VSon,VVitesse:Integer;
 Type Configuration=Object
            Procedure Init;
 End;
{----------------------------------------------------------------------------}
Implementation
Uses Dos,Crt;
{$L procpa}                            { Int‚grer le module Assembleur }

function GetProc : integer; external;
function GetCo   : integer; external;
{------------------------------------------------------------------------}
Function Tprocesseur:Integer;
Begin
Tprocesseur:=Getproc+1;
end;
{------------------------------------------------------------------------}
Function TCoprocesseur:Integer;
Begin
TCoprocesseur:=GetCo+1;
End;
{------------------------------------------------------------------------}
Function TVitesse:Real;
VAR
  Speed, DelayCalibrate : Word;
CONST
{$IFDEF Ver70} Offset = 9;
{$ELSE} {$IFDEF Ver60} Offset = 9;
{$ELSE} {$IFDEF Ver55} Offset = 9;
{$ELSE} {$IFDEF Ver50} Offset = 9;
{$ELSE} {$IFDEF Ver40} Offset = 16;
{$ELSE} CRASH HERE -- Fonctionne uniquement avec TP4 et post‚rieurs
{$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF}

BEGIN
  DelayCalibrate := MemW[Seg(CheckSnow):
                         Ofs(CheckSnow)+Offset];
  Speed := ((LongInt(1000) * DelayCalibrate) + 110970)
           DIV 438;
  CASE Speed OF
    0..499     : TVitesse:=4.77;
    500..699   : TVitesse:=6;
    700..899   : TVitesse:=8;
    900..1099  : TVitesse:=10;
    1100..1399 : TVitesse:=12;
    1400..1799 : TVitesse:=16;
    1800..2199 : TVitesse:=20;
    2200..2699 : TVitesse:=25;
    2700..3599 : TVitesse:=30;
    ELSE TVitesse:=50;
  End;
End;
{------------------------------------------------------------------------}
Function TMemoire:Integer;
Var Regs:Registers;
    Nombre:Integer;
    Nombre2:String;
    AT    :Boolean;
Begin
if mem[$f000:$fffe]=$fc then AT:=true
                        else AT:=false;
Intr($12,Regs);
Nombre:=Regs.ax;
if AT then
Begin
 Regs.ah:=$88;
 Intr($15,Regs);
  Regs.ah:=$88;
  Intr($15,Regs);
  Nombre:=Nombre+Regs.ax;
End;
TMemoire:=Nombre;
End;
{------------------------------------------------------------------------}
Function TEcran:Integer;
Var Regs:Registers;
Begin
Regs.Ah:=$1A;
Regs.Al:=0;
Intr($10,Regs);
If Regs.BL=$FF then Tecran:=8
Else TEcran:=Regs.Bl-1;
End;
{------------------------------------------------------------------------}
Function TPointeur:Integer;
Var GererSouris,
    GererStylo,
    GererTablette,
    GererJoystick,
    AT:Boolean;
    Regs:Registers;
Begin
 if mem[$f000:$fffe]=$fc then AT:=true
                        else AT:=false;

  Regs.AX:=$0000;
  Intr($33,Regs);
  If Regs.AX=$FFFF Then GererSouris:=True Else GererSouris:=False;
   If At Then
  Begin
      Regs.Ah:=$84;
      Regs.DX:=$0;
      Intr($15,Regs);
      If Regs.Flags=1 Then GererJoystick:=True Else GererJoystick:=False;
  End;
  If GererSouris Then TPointeur:=2
     Else If GererJoystick Then TPointeur:=3
        Else If GererStylo Then TPointeur:=4
          Else If GererTablette Then TPointeur:=5;
End;
{------------------------------------------------------------------------}
Procedure Configuration.Init;
Begin
VEcran:=TEcran;
VMemoire:=TMemoire;
VPointeur:=TPointeur;
VProcesseur:=TProcesseur;
VCoprocesseur:=TCoprocesseur;
VSysteme:=1;
VReseau:=1;
VLangue:=1;
VSon:=1;
Imprimante[1]:='';
Imprimante[2]:='.';
End;
{------------------------------------------------------------------------}
end.