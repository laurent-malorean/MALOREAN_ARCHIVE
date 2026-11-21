Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       Mul1     : Array [0..199] Of Word;
       Mul2     : Array [0..199] Of Word;
       Ofset1_f   : Word;
       Ofset2_f   : Word;
       Ofset1_g   : Word;
       Ofset2_g   : Word;
       ecr1       : ^Type_graph_ecran;

Begin;
New(ecr1);
Vga.GraphMode;
ecr1^:=vga_ecran;
LoadPal ('e:\tp\pal\Volcano.pal');
For f:=0 to 199 do Mul1[f]:=(f+100)*320+160;
For f:=0 to 199 do Mul2[f]:=(-f+100)*320+160;

for c:=20 to 500  do Begin;
                    for f:=0 to 99 do
                    for g:=f to 99 do Begin;
                                cou:=(f*g*c) and c;
                                      Ofset1_f:=Mul1[f];
                                      Ofset2_f:=Mul2[f];
                                      Ofset1_g:=Mul1[g];
                                      Ofset2_g:=Mul2[g];

                                      vga_ecran[Ofset1_g+f]:=Cou;
                                      vga_ecran[Ofset1_f+g]:=cou;
                                      vga_ecran[Ofset2_g+f]:=Cou;
                                      vga_ecran[Ofset2_f+g]:=Cou;
                                      vga_ecran[Ofset2_g-f]:=Cou;
                                      vga_ecran[Ofset2_f-g]:=cou;
                                      vga_ecran[Ofset1_g-f]:=Cou;
                                      vga_ecran[Ofset1_f-g]:=Cou;

                                       end;
{                                       Vga_ecran:=ecr1^;}
                    end;
VGA.TextMode;

END.