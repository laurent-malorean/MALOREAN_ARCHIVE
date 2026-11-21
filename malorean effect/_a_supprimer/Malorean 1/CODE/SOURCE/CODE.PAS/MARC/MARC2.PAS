Uses gest_graph,Dac_code,dac_frac,crt;
Var    X        : word;
       Y        : word;
       cou      : Byte;

Begin;
GraphMode;
Put_Dac(dac_frac.Blue);
for X:=1 to 319 do
for Y:=1 to 199 do Begin;
                  cou:=3*X+X*Y-Y;
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
delay(3000);
END.