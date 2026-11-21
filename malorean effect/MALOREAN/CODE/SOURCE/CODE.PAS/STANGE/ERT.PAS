Uses CGraph,crt,dac_code,dac_frac;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       ECR1     : ^Type_graph_ecran;
       x        : Word;
       dir      : byte;
       co120    : Array [0..360] of Integer;
       si80     : Array [0..360] of Integer;

Begin;
new(ecr1);
Vga.GraphMode;
put_dac(pal2);
x:=0;
For f:=0 to 63999 do ecr1^[f]:=0;

For F:=0 to 360 do Begin;
                    Co120 [F]:=Round(120*cos(pi/180*F))+150;
                    Si80  [F]:=Round(80*sin(pi/180*F)) +85;
                    End;

for c:=0 to 500  do Begin;
                    
                    x:=x+5;
                    dir:=dir;
                    if x>360 then x:=0;
                    for f:=0 to 32 do
                    for g:=0 to 32 do Vga.Putpixel
                    (ECr1^,f+co120[x],g+si80[x],f*g*c and c );

                    for f:=0 to 64 do
                    for g:=0 to 64 do Vga.Putpixel
                    (ECr1^,f+130,g+70,f*g*c and c );
                    Vga_ecran:=ecr1^;
                    end;
VGA.TextMode;

END.