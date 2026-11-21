PROGRAM flocon_de_neige;
USES graph,crt;
VAR i,x,y,z,t,carte,mode:integer;
                       n:byte;
                      ch:char;

PROCEDURE flocon(x,y,z,t:integer;n:byte);
var  a,b,c,d,e,f:integer;
begin
  if n=0 then line(x,y,z,t)
         else begin
                a:=trunc((2*x+z)/3);
                b:=trunc((2*y+t)/3);
                e:=trunc((x+2*z)/3);
                f:=trunc((y+2*t)/3);
                c:=a+trunc(0.5*(e-a)+sqrt(3)/2*(f-b));
                d:=b+trunc(-sqrt(3)/2*(e-a)+0.5*(f-b));
                flocon(x,y,a,b,n-1);
                flocon(a,b,c,d,n-1);
                flocon(c,d,e,f,n-1);
                flocon(e,f,z,t,n-1);
              end;
end;

BEGIN
carte:=detect;
INITGRAPH(carte,mode,'c:\utiliter\turbo6\bgi');
i:=0;
REPEAT
  clearviewport;
  flocon(320,1,525,340,i);
  flocon(525,340,115,340,i);
  flocon(115,340,320,1,i);
  i:=i+1;
  ch:=readkey;
UNTIL ch<>' ';
CLOSEGRAPH;
END.
