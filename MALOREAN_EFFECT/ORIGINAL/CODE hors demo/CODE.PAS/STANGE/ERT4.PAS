Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       ECR1     : ^Type_graph_ecran;
       ECR2     : ^Type_graph_ecran;

       x        : Word;
       dir      : byte;
       co120    : Array [0..360] of Integer;
       si80     : Array [0..360] of Integer;
       a,b      : integer;
       cou      : Byte;
       mul1616  : Array [0..256] Of Word;


Begin;
new(ecr1);
New(ecr2);
Vga.GraphMode;
x:=0;
For f:=0 to 15 do for g:=0 to 15 do mul1616[f shl 4 +g]:=(f+1)*(g+1);
For f:=0 to 63999 do ecr1^[f]:=0;
Ecr2^:=Ecr1^;

For F:=0 to 360 do Begin;
                    Co120 [F]:=Round(120*cos(pi/180*F));
                    Si80  [F]:=Round(80*sin(pi/180*F)) ;
                    End;

for c:=0 to 500  do Begin;
                    
                    x:=x+14;
                    dir:=dir;
                    if x>360 then Begin;
                                  x:=0;
                                  ecr1^:=Ecr2^;
                                  end;
                    a:=co120[x];
                    b:=si80[x];
                    for f:=0 to 16 do
                    for g:=0 to 16 do Begin;
                                      cou:=mul1616[f shl 4 +g]*c and c;
                                      Vga.Putpixel (ECr1^,f+a+160,g+b+100,cou );
                                      Vga.Putpixel (ECr1^,-f+160+a,-g+b+100,cou );
                                      Vga.Putpixel (ECr1^,-f+a+160,g+b+100,cou );
                                      Vga.Putpixel (ECr1^,f+a+160,-g+b+100,cou );
                                      End;

                    for f:=0 to 32 do
                    for g:=0 to 32 do Begin;
                                      cou:=f*g*c and c;
                                      Vga.Putpixel  (ECr1^,-f+160,g+100,cou );
                                      Vga.Putpixel  (ECr1^,f+160,-g+100,cou );
                                      Vga.Putpixel  (ECr1^,-f+160,-g+100,cou );
                                      Vga.Putpixel  (ECr1^,f+160,g+100,cou );

                                      end;
                    Vga_ecran:=ecr1^;
                    end;
VGA.TextMode;

END.