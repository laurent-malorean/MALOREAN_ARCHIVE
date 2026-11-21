Uses gest_graph,Dac_code,dac_frac,crt;
Var    X        : word;
       Y        : word;
       cou      : Byte;

Begin;
GraphMode;
Put_Dac(dac_frac.Blue);
for X:=1 to 319 do
for Y:=1 to 199 do Begin;
                  cou:=X +(x and y) div 10 + y;
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
delay(2 000);
END.