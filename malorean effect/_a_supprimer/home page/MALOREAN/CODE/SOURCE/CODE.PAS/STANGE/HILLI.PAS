Uses CGraph,Crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       ECR1     : ^Type_graph_ecran;
       ECR2     : ^Type_graph_ecran;

       cou      : Byte;
       x,y : byte;


Begin;

new(ecr1);
New(ecr2);
Vga.GraphMode;
For f:=0 to 63999 do ecr1^[f]:=0;
Ecr2^:=Ecr1^;
c:=1;
for y:=1 to 6 do
 for x :=1 to 10 do begin;

inc(c);

                    for f:=0 to 16 do
                    for g:=0 to 16 do Begin;
                                      cou:=(f*g) mod c;

                          Vga.Putpixel (ECr1^,f+x*32-16,g+y*32-16,cou );
                          Vga.Putpixel (ECr1^,-f+x*32-16,-g+y*32-16,cou );
                          Vga.Putpixel (ECr1^,-f+x*32-16,g+y*32-16,cou );
                           Vga.Putpixel (ECr1^,f+x*32-16,-g+y*32-16,cou );
                                      End;


                    Vga_ecran:=ecr1^;
                    end;
delay(1000);

END.