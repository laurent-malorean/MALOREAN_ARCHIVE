Uses gest_graph,crt;
Var    f        : word;
       g        : word;
       c        : word ;
       x,y      : Real;
       ang      : integer;
       dir : byte;

Begin;
GraphMode;
ang:=0;
for c:=0 to 500  do Begin;
                    x:=x+0.1;
                    dir:=dir;
                    if ang>360 then ang:=0;
                    for f:=0 to 32 do
                    for g:=0 to 32 do Putpixel
                    (f+round(120*cos(x))+150,g+round(80*sin(x))+85,f*g*c and c );
                    for f:=0 to 64 do
                    for g:=0 to 64 do Putpixel
                    (f+130,g+70,f*g*c or c );
                    end;
TextMode(0);

END.