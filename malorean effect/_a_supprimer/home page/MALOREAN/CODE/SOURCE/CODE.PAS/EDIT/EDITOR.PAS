USES CSCREEN,Crt;


VAR  WinEdit    : ObjWIn;
     WinButton  : ObjWin;

     TableL     : Array [1..250] Of Byte;
     f : byte;

PROCEDURE CreatWinEdit;
BEGIN;
WinEdit.Win3 (WorkScreen,'Malorean Effect Assembleur Editor',1,1,60,24,Blanc,Bleu,magenta);
WinButton.Win3 (WorkScreen,'Tools',65,1,80,24,Blanc,Bleu,Vert);
MovEcran (Ecran,WorkSCreen);
END;

Procedure LoadFile (Name : String);
VAR  Fichier     :  FILE;
BEGIN;  Assign(Fichier,Name);
        Reset(Fichier);
        BlockRead(Fichier,TableL,SizeOf(TableL));
        Close(Fichier);
END;

BEGIN;
{CreatWinedit;}
clrscr;
LoadFile ('p.asm');
textcolor(7);
for f:=0 to 255 do write(chr(TableL[f]));
delay(500);

END.