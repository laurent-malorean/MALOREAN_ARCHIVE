Uses gest_graph,Dac_code,dac_frac,crt;
Var    X,Y,Z    : word;
       cou      : Byte;
Begin;
GraphMode;
Put_Dac(dac_frac.Pal4);

for Z:=1 to 060 do
for X:=1 to 319 do
for Y:=1 to 199 do Begin;
                  cou:=((x+z) and (y+z)) xor (x or Y);
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
delay(2000);
END.