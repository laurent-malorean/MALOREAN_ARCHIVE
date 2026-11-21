Uses gest_graph,Dac_code,dac_frac,crt;
Var    X,Y,Z    : word;
       cou      : Byte;
       Carre    : Array[1..500] Of Word;
Begin;
GraphMode;
Put_Dac(dac_frac.Pal4);
for X:=0 to 500 do Carre[X]:=X*X;

for Z:=1 to 199 do
for X:=1 to 199 do
for Y:=1 to 199 do Begin;
                  cou:=Carre[((X-Z) or (Y+Z))];
                  Vga[Mul320[Y]+X]:=Cou;
                  end;
delay(2000);
END.