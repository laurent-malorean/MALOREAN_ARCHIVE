Uses Gest_Graph,gest_dac,crt;

const nbpt=1000;

var dx,dy : array [1..nbpt] of integer;
var x,y   : array [1..nbpt] of Integer;
var f : longint;
var g : longint;
Var angle1,angle2 : real;
BEGIN
graphmode;
put_dac(gest_dac.blue);
For g:=1 to 500000 do
For f:=1 to 500000 do begin;
X[1]:=160+round(130*cos(angle1)*Sin(angle2));
y[1]:=100+round(90*Sin(angle1));
Vga[mul320[y[1]]+x[1]]:=Vga[mul320[y[1]]+x[1]]+1;
angle1:=angle1+0.005464646;
angle2:=angle2+0.0105525;
end;

END.