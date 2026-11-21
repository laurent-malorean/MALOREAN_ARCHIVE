USES GEST_GRAPH,DAC_CODE,DAC_FRAC,crt,GRAPH4p;

Var Pal : Tpal;
Var r,v,b  : Word;
Var c1,c2,c3  : Word;

PROCEDURE MARC_9;
Var    X,Y,Z    : word;
       cou      : Byte;
Begin;
{Put_Dac(dac_frac.Pal4);}
For r:=0 to 255 do
For v:=0 to 255 do
For b:=0 to 255 do Pal[3*r+3*v+1+3*b+2]:=r+v+b+10 mod 64;
Put_Dac(Pal);

for Z:=1 to 060 do
for X:=1 to 319 do
for Y:=1 to 199 do Begin;
                  cou:=((x+z) and (y+z)) xor (x or Y);
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
END;

BEGIN;
Graph_Mode_4;
Marc_9;
END.