Uses Gest_Graph,gest_dac,crt;

const nbpt=1000;

var dx,dy : array [1..nbpt] of integer;
var x,y   : array [1..nbpt] of Integer;
var f : longint;
var g : longint;
Var angle1,angle2 : real;
BEGIN
graphmode;
put_dac(gest_dac.volpone1);

For f:=1 to 500000 do begin;
X[1]:=160+round(random(130)*cos(random(4)*angle1)*Sin(random(4)*angle2));
y[1]:=100+round(random(90)*Sin(angle1));
Vga[mul320[y[1]]+x[1]]:=Vga[mul320[y[1]]+x[1]]+10;
angle1:=angle1+0.005464646;
angle2:=angle2+0.0105525;
end;

END.