Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       ECR1     : ^Type_graph_ecran;
       x        : real;
Begin;
new(ecr1);
Vga.GraphMode;
x:=0;

for c:=0 to 500  do Begin;
                    x:=x+0.1;
                    for f:=130 to 190 do
                    for g:=70 to 130 do
                    Vga.Putpixel (ECr1^,Round ( (f-160)*cos(x)-(g-100)*sin(x)+160 ),
                    Round ( (f-160)*sin(x)+(g-100)*cos(x) + 100),f*g*c and c );
                    Vga_ecran:=ecr1^;
                    end;
VGA.TextMode;

END.