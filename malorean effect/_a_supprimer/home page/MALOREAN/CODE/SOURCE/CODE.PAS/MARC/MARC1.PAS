Uses gest_graph,Dac_code,dac_frac,crt;
Var    X        : word;
       Y        : word;
       cou      : Byte;

Begin;
GraphMode;
Put_Dac(dac_frac.Pal4);
for X:=1 to 319 do
for Y:=1 to 199 do Begin;
                  cou:=X+(Y and (Y And (Y*X)));
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
delay(3000);
END.