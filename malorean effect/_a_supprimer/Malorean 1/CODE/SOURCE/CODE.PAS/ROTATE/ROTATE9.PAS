Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       cou1,cou2,cou3 : Byte;
       Mul1     : Array [0..199] Of Word;
       Mul2     : Array [0..199] Of Word;
       Ofset1_f   : Word;
       Ofset2_f   : Word;
       Ofset1_g   : Word;
       Ofset2_g   : Word;
       x,y :array[0..99] Of Byte;


Begin;
Vga.GraphMode;
LoadPal ('e:\tp\pal\volcano.pal');
For f:=0 to 199 do Mul1[f]:=(f+100)*320+160;
For f:=0 to 199 do Mul2[f]:=(-f+100)*320+160;
for f:=0 to 99 do X[f]:=f;
for f:=0 to 99 do y[f]:=f;

for c:=0 to 5000  do Begin;
                     inc(c,3);
                    for f:=1 to 99 do Begin;
                                      x[f]:=((x[f] shr 1)+((y[f] and 1) Shl 7));
                    for g:=f to 99 do Begin;
                                      y[g]:=((y[g] shr 1)+((x[g] and 1) Shl 7));

cou :=x[c+g+f]-y[c+f] and ((f*g*c) and c);

                                      Ofset1_f:=Mul1[f];
                                      Ofset2_f:=Mul2[f];
                                      Ofset1_g:=Mul1[g];
                                      Ofset2_g:=Mul2[g];

                                      Vga_Ecran[Ofset1_g+f]:=Cou;
                                      Vga_Ecran[Ofset1_f+g]:=cou;
                                      Vga_Ecran[Ofset2_g+f]:=Cou;
                                      Vga_Ecran[Ofset2_f+g]:=Cou;
                                      Vga_Ecran[Ofset2_g-f]:=Cou;
                                      Vga_Ecran[Ofset2_f-g]:=cou;
                                      Vga_Ecran[Ofset1_g-f]:=Cou;
                                      Vga_Ecran[Ofset1_f-g]:=Cou;

                                       end;
                                       end;
                    end;
VGA.TextMode;

END.