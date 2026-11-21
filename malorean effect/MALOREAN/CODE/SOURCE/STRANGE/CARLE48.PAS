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


Begin;
Vga.GraphMode;
LoadPal ('e:\tp\pal\Volcano.pal');
For f:=0 to 199 do Mul1[f]:=(f+100)*320+160;
For f:=0 to 199 do Mul2[f]:=(-f+100)*320+160;

for c:=1 to 15 do Begin;
                    for f:=1 to 99 do
                    for g:=f to 99 do Begin; {en rapport avec carle20}
                                       Ofset1_f:=Mul1[f];
                                      Ofset2_f:=Mul2[f];
                                      Ofset1_g:=Mul1[g];
                                      Ofset2_g:=Mul2[g];

                                 cou:=Vga_Ecran[Ofset1_g+f]- ((f-g) and (g-f) or (f-c) or (g-c));
 
                        Vga_Ecran[Ofset1_g+f]:= Cou;
                        Vga_Ecran[Ofset1_f+g]:=cou;
                        Vga_Ecran[Ofset2_g+f]:= Cou;
                        Vga_Ecran[Ofset2_f+g]:=Cou;
                        Vga_Ecran[Ofset2_g-f]:= Cou;
                        Vga_Ecran[Ofset2_f-g]:=cou;
                        Vga_Ecran[Ofset1_g-f]:=Cou;
                        Vga_Ecran[Ofset1_f-g]:= Cou;

                                       end;
                                       delay(300);
                    end;


delay(5000);
VGA.TextMode;

END.

