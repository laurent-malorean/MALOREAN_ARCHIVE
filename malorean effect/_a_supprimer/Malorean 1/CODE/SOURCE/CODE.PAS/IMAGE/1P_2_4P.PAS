{CONVERTIT IMAGE SHOOT 1 PLAN DE BITE EN FICHIER 4PLAN DE BIT}


USES CGraph;


VAR Plan1       :  Array [0..15999] Of Byte;
    Plan2       :  Array [0..15999] Of Byte;
    Plan3       :  Array [0..15999] Of Byte;
    Plan4       :  Array [0..15999] Of Byte;


Procedure Convert (Nomsource,NomDestination  : String);
Var VGaECran    : ^Screen;
    Merde       :  Byte;
    Fichier     :  FILE;
    x           :  Word;
    y           :  word;

Begin;
  New(VgaEcran);
  Assign(Fichier,nomSource);
  Reset(Fichier, 1);
  BlockRead(Fichier,Merde,SizeOf(Merde));
  BlockRead(Fichier,VgaEcran^.Palette,SizeOf(VgaEcran^.Palette));
  BlockRead(Fichier,VGaEcran^.ECran,SizeOf(VGaEcran^.Ecran));
  Close(Fichier);

y:=0;
For x:=0 to 15999 Do BEGIN;
                     Plan1[x]:=VgaEcran^.Ecran[Y];
                     inc(y,4);
                     END;
y:=1;
For x:=0 to 15999 Do BEGIN;
                     Plan2[x]:=VgaEcran^.Ecran[Y];
                     inc(y,4);
                     END;
y:=2;
For x:=0 to 15999 Do BEGIN;
                     Plan3[x]:=VgaEcran^.Ecran[Y];
                     inc(y,4);
                     END;
y:=3;
For x:=0 to 15999 Do BEGIN;
                     Plan4[x]:=VgaEcran^.Ecran[Y];
                     inc(y,4);
                     END;

Assign(Fichier,nomDestination);
Rewrite(Fichier,1);
BlockWrite(Fichier,Merde,SizeOf(Merde));
BlockWrite(Fichier,VgaEcran^.Palette,SizeOf(VgaEcran^.Palette));
BlockWrite(Fichier,Plan1,16000);
BlockWrite(Fichier,Plan2,16000);
BlockWrite(Fichier,Plan3,16000);
BlockWrite(Fichier,Plan4,16000);
Close(Fichier);

end;


BEGIN;
convert(ParamStr(1),Paramstr(2));


END.