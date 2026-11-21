Uses Gest_Graph,gest_dac,crt;

const nbpt=1000;

var dx,dy : array [1..nbpt] of integer;
var x,y   : Integer;
var f : longint;
var g : longint;
Var angle1,angle2 : real;
BEGIN
graphmode;
put_dac(gest_dac.volpone1);

For f:=1 to 500000 do begin;
for x:=0 to 180 do
for y:=0 to 180 do
Vga[mul320[y]+x]:=Vga[mul320[y]+x]+round(3*cos(x+y+f));

end;

END.