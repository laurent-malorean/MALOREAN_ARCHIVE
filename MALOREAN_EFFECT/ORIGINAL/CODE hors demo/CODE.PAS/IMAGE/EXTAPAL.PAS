Uses CGraph,Dos,Crt;

Var
    VGaECran    : ^Screen;
    Merde       :  Byte;
    Fichier     :  FILE;
    Vga         :  TGraphVga;
    Pal         :  T2_Palette;
    F           :  Word;
    g           :  byte;

Procedure Charge_ME ;
Begin;
  Assign(Fichier,ParamStr(1));
  Reset(Fichier, 1);
  BlockRead(Fichier,Merde,SizeOf(Merde));
  BlockRead(Fichier,VgaEcran^.Palette,SizeOf(VgaEcran^.Palette));
  BlockRead(Fichier,VGaEcran^.ECran,SizeOf(VGaEcran^.Ecran));
  Close(Fichier);

  Assign(Fichier,ParamStr(2));
  Rewrite(Fichier, 1);
  BlockWrite(Fichier,VgaEcran^.Palette,SizeOf(VgaEcran^.Palette));
  close (fichier);
end;



BEGIN;
NEW (VGaECran);
Charge_me ;
end.