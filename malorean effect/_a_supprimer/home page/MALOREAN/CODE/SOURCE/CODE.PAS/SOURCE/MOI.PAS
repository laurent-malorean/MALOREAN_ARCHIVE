Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       ECR1     : ^Type_graph_ecran;
       x,y      : Real;
       ang      : integer;
       dir : byte;

Begin;
new(ecr1);
Vga.GraphMode;
ang:=0;
For f:=0 to 63999 do ecr1^[f]:=0;

for c:=0 to 500  do Begin;
                    
                    x:=x+0.1;
                    dir:=dir;
                    if ang>360 then ang:=0;
                    for f:=0 to 32 do
                    for g:=0 to 32 do Vga.Putpixel
                    (ECr1^,f+round(120*cos(x))+150,g+round(80*sin(x))+85,f*g*c and c );
                    for f:=0 to 64 do
                    for g:=0 to 64 do Vga.Putpixel
                    (ECr1^,f+130,g+70,f*g*c or c );
                    Vga_ecran:=ecr1^;
                    end;
VGA.TextMode;

END.