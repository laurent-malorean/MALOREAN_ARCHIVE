UNIT CGraph;


INTERFACE


Type      Type_graph_ecran  = Array [0..63999] of Byte;
          Type2_graph_ecran = Array [0..199,0..319] of Byte;

          T1_Palette = Record
                       R : Byte;
                       V : Byte;
                       B : Byte;
                      End;
          T_Pointeur = Record
                       Segment : Byte;
                       Ofset   : Byte;
                       End;
          T2_Palette = Array [0..255] Of T1_Palette;
          Screen     = Record
                       Palette   : T2_Palette;
                       Ecran     : Type_Graph_Ecran;
                       Pointeur  : T_Pointeur;
                     End;



TGraphVga   = OBJECT
              Procedure PutPIxel      (Var Buffer  : Type_graph_ecran;
                                           X,Y     : Word;
                                           Couleur : Byte);

              Function GetPixel      (Var Buffer   : Type_graph_ecran;
                                          X,Y      : Word           ) :Byte ;


              Procedure GraphMode;
              Procedure TextMode;
              END;

ObjPalette = OBJECT
              Palette  : T2_Palette;
              Procedure Init         ( Pal     : T2_Palette);
              Procedure SetDac       ( Depart      : Byte;
                                       Longueur    : Byte;
                                       Buffer      : T2_Palette);

              Procedure GetDac       (      Depart      : Byte;
                                            Longueur    : Byte;
                                       Var  Buffer : T2_Palette);
              Procedure SetDacPAl;

              Procedure GetDacPal;

              Procedure Inc1Dac      ;
              Procedure Dec1Dac      ;

             END;

VAR   VGa_ecran     : Type_Graph_Ecran  ABSOLUTE $A000:$0000;
VAR   VGa_Tableau   : Type2_Graph_Ecran  ABSOLUTE $A000:$0000;

      t : array [0..199] of Word;


{Charge fichier copie de la mem ecran pour VGA}
Procedure Charge_fichier_Vga (     Name   : String;
                              Var  Buffer : TYpe_graph_ecran);

Procedure Sauve_fichier_Vga (    Name   : String);

Procedure Droite     (X1,Y1,X2,Y2,C : Byte);


Procedure loadpal (name  : String);

Procedure Charge_Shoot (nom : string);
Procedure Sauve_Shoot  (Nom : String);

IMPLEMENTATION

Uses DOS;

{░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓}

Procedure Charge_Shoot;
Var
    Merde       :  Byte;
    Fichier     :  FILE;
    Vga         :  TGraphVga;
    Palette     : ObjPalette;
    Pal         :  T2_Palette;

Begin;
  Assign(Fichier,nom);
  Reset(Fichier, 1);
  BlockRead(Fichier,Merde,1);
  BlockRead(Fichier,Pal,768);
  BlockRead(Fichier,VGa_Ecran,64000);
  Close(Fichier);
  Palette.SetDAc (0,255,Pal);
end;

Procedure Sauve_Shoot;
Var Merde       :  Byte;
    Fichier     :  FILE;
    Vga         :  TGraphVga;
    Palette     :  ObjPalette;
    PalSauve    :  T2_Palette;

Begin;
  Palette.GetDAc(0,255,PalSauve);
  Assign(Fichier,nom);
  Rewrite(Fichier,1);
  BlockWrite(Fichier,Merde,SizeOf(Merde));
  BlockWrite(Fichier,PalSauve,SizeOf(PalSauve));
  BlockWrite(Fichier,Vga_Ecran,SizeOf(VGa_Ecran));
  Close(Fichier);
end;



Procedure loadpal;
VAR     Vga         :  ObjPalette;
        Pal         :  T2_Palette;
        Fichier     : File;
begin;
  Assign(Fichier,Name);
  Reset(Fichier, 1);
  BlockRead(Fichier,Pal,SizeOf(Pal));
  Close(Fichier);
  VGA.SetDAc (0,255,Pal);
end;


Procedure Charge_Fichier_Vga;
Var f_mem : File of Type_graph_ecran;

Begin;
Assign(F_mem,name);
Reset (F_mem);
Read (F_mem,buffer);
Close(F_mem);
End;

Procedure sauve_fichier_Vga;
Var
f_mem     : File of Type_Graph_ecran;

Begin;
Assign(F_mem,name);
Rewrite (F_mem);
Write(F_mem,VGA_ecran);
Close(F_mem);
end;


{--------------------------------------------------------------------------}

Procedure Droite  ;
VAR Dx,Dy        : Byte;
    Dx2,Dy2      : Byte;
    S1,S2        : ShortInt;
    X,Y          : Byte;
    Erreur       : Integer;
    Temp         : Byte;
    InterChange  : Byte;
    F            : Byte;
    VGA          : TGraphVga;

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
                  VGA.Putpixel (vga_ecran,x,y,c);
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
Procedure TGraphVga.GraphMode;
BEGIN;
ASM
   MOV AX,$13;
   INT $10;
   END;
END;
{--------------------------------------------------------------------------}
Procedure TGraphVga.TextMode;
BEGIN;
ASM
    MOV AX,$03;
    INT $10;
END;
END;
{--------------------------------------------------------------------------}
Procedure TGraphVga.Putpixel;

BEGIN;
Buffer[t[y]+x]:=couleur;
END;

Procedure tm;
var f: byte;
begin;
for f:=0 to 199 do t[f]:=f*320;
end;

{--------------------------------------------------------------------------}
Function TGraphVga.GetPixel;
BEGIN;
GetPixel:=Buffer[y*320+x];
END;

{************************************************************************}

Procedure ObjPalette.SetDac;
VAR       Reg : Registers;
BEGIN;
Reg.AX:=$1012;
Reg.BX:=Depart;
Reg.CX:=Longueur;
Reg.ES:=Seg(Buffer);
Reg.DX:=Ofs(Buffer);
intr($10,Reg);
END;

Procedure ObjPalette.GetDac;
VAR       Reg : Registers;
BEGIN;
Reg.AX:=$1017;
Reg.BX:=Depart;
Reg.CX:=Longueur;
Reg.ES:=Seg(buffer);
Reg.DX:=Ofs(Buffer);;
intr($10,Reg);
END;

Procedure ObjPalette.SetDacPal;
VAR       Reg : Registers;
BEGIN;
Reg.AX:=$1012;
Reg.BX:=0;
Reg.CX:=255;
Reg.ES:=Seg(Palette);
Reg.DX:=Ofs(Palette);
intr($10,Reg);
END;

Procedure ObjPalette.GetDacPAl;
VAR       Reg : Registers;
BEGIN;
Reg.AX:=$1017;
Reg.BX:=0;
Reg.CX:=255;
Reg.ES:=Seg(Palette);
Reg.DX:=Ofs(Palette);;
intr($10,Reg);
END;


Procedure ObjPalette.Inc1Dac;
VAR       F        : Byte;
          PalInter : T2_Palette;
BEGIN;
PalInter:=Palette;
For F:=1 To 255 Do Palette[f]:=PalInter[f-1];
Palette[1]:=PalInter[255];
SetDacPal;
END;

Procedure ObjPalette.Dec1Dac;
VAR       F        : Byte;
          PalInter : T2_Palette;
BEGIN;
PalInter:=Palette;
For F:=0 To 254 Do Palette[f]:=PalInter[f+1];
Palette[255]:=PalInter[1];
SetDacPal;
END;

Procedure ObjPalette.Init;
BEGIN;  Palette:=Pal;
END;

BEGIN;
Tm;
End.




