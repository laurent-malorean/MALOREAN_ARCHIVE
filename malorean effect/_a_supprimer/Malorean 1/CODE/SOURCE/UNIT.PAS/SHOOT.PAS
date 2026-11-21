UNIT SHOOT;

INTERFACE
Uses GEST_GRAPH,GEST_DAC;

Procedure LoadShoot (Nom : String);
Procedure SaveShoot (Nom : String);



IMPLEMENTATION

{-------------------------------------------------------------------------}
Procedure LoadShoot;
Var       Merde       :  Byte;
          Fichier     :  FILE;
          Pal         :  TPal;

Begin;    Assign(Fichier,nom);
          Reset(Fichier, 1);
          BlockRead(Fichier,Merde,1);
          BlockRead(Fichier,Pal,768);
          BlockRead(Fichier,VGA,64000);
          Close(Fichier);
          PUT_DAC  (Pal);
end;
{-------------------------------------------------------------------------}
Procedure SaveShoot;
VAR       Merde       :  Byte;
VAR       Fichier     :  FILE;
VAR       PalSauve    :  TPal;

Begin;    GET_DAC(PalSauve);
          Assign(Fichier,nom);
          Rewrite(Fichier,1);
          BlockWrite(Fichier,Merde,SizeOf(Merde));
          BlockWrite(Fichier,PalSauve,SizeOf(PalSauve));
          BlockWrite(Fichier,VGA,64000);
          Close(Fichier);
end;
{-------------------------------------------------------------------------}


BEGIN
END.

