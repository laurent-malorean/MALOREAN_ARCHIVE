Uses gest_graph,Dac_code,dac_frac,crt;
Var    X        : word;
       Y        : word;
       Z        : word;
       cou      : Byte;
       compteur : real;
       Table    : Array[1..100,1..199] of word;

Begin;
GraphMode;
Put_Dac(dac_frac.Pal4);
compteur:=0;
for z:=0 to 20  do begin;
                   compteur:=compteur+0.1;
for Y:=1 to 199 do Begin;
                  Table[Z,Y]:=ROund(compteur*y);
end;
end;

for z:=0 to 20  do begin;
for X:=1 to 200 do
for Y:=1 to 199 do Begin;
                  cou:=(x+Table[Z,Y]) and y;  {faire varier le 2}
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
                  end;
delay(2000);
END.