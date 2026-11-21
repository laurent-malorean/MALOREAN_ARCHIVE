Uses GESt_GRAPH,GEST_DAC,CRT;

Const Lx      = 319;
      Ly      = 199;
      Lz      = 100;
Var X,Y,Z     : Integer;
    R         : REal;
    R2        : Longint;
    Tx        : Array [0..Lx] of real;
    Ty        : Array [0..Ly] of real;
    Tz        : Array [0..Lz] of real;

    Tx1,Tx2,
    Tz1,Tz2,
    Ty1,Ty2   : Real;

BEGIN
GraphMode; Put_DAc(gest_dac.Blue);
Tx1:=-1.0;   Tx2:=+1.0;
Ty1:=-1.0;   Ty2:=+1.0;
Tz1:=-10.0;   Tz2:=+10.0;

For Z:=0 to Lx Do  Tx[z]:=Tx1+(tx2-Tx1)/Lx*z;
For Z:=0 to Ly Do  Ty[z]:=Ty1+(ty2-Ty1)/Ly*z;
For Z:=0 to Lz Do  Tz[z]:=Tz1+(tz2-Tz1)/Lx*z;


For Z:=0 to Lz Do
For X:=0 to Lx do
For Y:=0 to Ly Do Begin;
R:={tx[x]*tx[x]*tx[x]*tx[x]}-tx[x]*tx[x]+Ty[y]*Ty[y]+Tz[z]*Tz[z];
R2:=Round(R*2000);
PutPixel(x,y,r2+z);

end;
delay(25000);
END.