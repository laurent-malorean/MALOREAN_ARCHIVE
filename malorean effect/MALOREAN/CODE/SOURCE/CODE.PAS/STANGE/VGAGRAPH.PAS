Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       ECR1     : ^Type_graph_ecran;
       Couleur  : Byte;
Begin;
new(ecr1);
Vga.GraphMode;
for c:=15 to 50   do Begin;
                    for f:=0 to 320 do
                    for g:=0 to 199 do Begin;
                                       Couleur:=f*g*c and c;
                                       Vga.Putpixel (ecr1^,f,g,couleur );
                                       Vga.Putpixel (ecr1^,f,g,couleur );
                                       Vga.Putpixel (ecr1^,f,g,couleur );
                                       Vga.Putpixel (ecr1^,f,g,f*g*c and c );
                                       end;
                    Vga_ecran:=ecr1^;
                    end;
VGA.TextMode;

END.