Uses CGraph;
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

       Mul1     : Array [0..199] Of Word;
       Mul2     : Array [0..199] Of Word;
       Ofset1_f   : Word;
       Ofset2_f   : Word;
       Ofset1_g   : Word;
       Ofset2_g   : Word;


Begin;
For f:=0 to 199 do Mul1[f]:=(f+100)*320+160;
For f:=0 to 199 do Mul2[f]:=(-f+100)*320+160;

new(ecr1);
New(ecr2);
Vga.GraphMode;
x:=0;
For f:=0 to 63999 do ecr1^[f]:=0;
Ecr2^:=Ecr1^;

For F:=0 to 360 do Begin;
                    Co120 [F]:=Round(120*cos(pi/180*F));
                    Si80  [F]:=Round(80*sin(pi/180*F)) ;
                    End;

for c:=1 to 100  do Begin;

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
                                      cou:=f*g*c and c;

                                      Vga.Putpixel (ECr1^,f+a+160,g+b+100,cou );
                                      Vga.Putpixel (ECr1^,-f+160+a,-g+b+100,cou );
                                      Vga.Putpixel (ECr1^,-f+a+160,g+b+100,cou );
                                      Vga.Putpixel (ECr1^,f+a+160,-g+b+100,cou );
                                      End;

                    for f:=0 to 40 do
                    for g:=f to 40 do Begin;
                                      cou:=f*g*c and (c+f+g);

                                      Ofset1_f:=Mul1[f];
                                      Ofset2_f:=Mul2[f];
                                      Ofset1_g:=Mul1[g];
                                      Ofset2_g:=Mul2[g];

                                      ecr1^[Ofset1_g+f]:=Cou;
                                      ecr1^[Ofset1_f+g]:=cou;
                                      ecr1^[Ofset2_g+f]:=Cou;
                                      ecr1^[Ofset2_f+g]:=Cou;
                                      ecr1^[Ofset2_g-f]:=Cou;
                                      ecr1^[Ofset2_f-g]:=cou;
                                      ecr1^[Ofset1_g-f]:=Cou;
                                      ecr1^[Ofset1_f-g]:=Cou;


                            {          Vga.Putpixel  (ECr1^,f+160,g+100,cou );
                                      Vga.Putpixel  (ECr1^,-f+160,g+100,cou );
                                      Vga.Putpixel  (ECr1^,-f+160,-g+100,cou );
                                      Vga.Putpixel  (ECr1^,f+160,-g+100,cou );}

                                      end;
                    Vga_ecran:=ecr1^;
                    end;
VGA.TextMode;

END.