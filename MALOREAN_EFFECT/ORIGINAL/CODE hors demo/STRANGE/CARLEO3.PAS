Uses CGraph,crt;

Type  tmul = Array [0..199] Of Word;
      tt   = Array [1..9000] OF Word;


Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       Mul1     : ^tmul;
       Mul2     : ^tmul;
       Ofset1_f   : Word;
       Ofset2_f   : Word;
       Ofset1_g   : Word;
       Ofset2_g   : Word;
       t1,t2,t3,t4,t5,t6,t7,t8 : Array [1..2000] OF Word;
       indent : Word;

Begin;
New(mul1);
new(mul2);
Vga.GraphMode;
LoadPal ('e:\tp\pal\Volcano.pal');
For f:=0 to 199 do Mul1^[f]:=(f+100)*320+160;
For f:=0 to 199 do Mul2^[f]:=(-f+100)*320+160;
Indent:=1;
  for f:=0 to 60 do
    for g:=f to 60 do Begin;
                      Ofset1_f:=Mul1^[f];
                      Ofset2_f:=Mul2^[f];
                      Ofset1_g:=Mul1^[g];
                      Ofset2_g:=Mul2^[g];

                      t1[indent]:=Ofset1_g+f;
                      t2[indent]:=Ofset1_f+g;
                      t3[indent]:=Ofset2_g+f;
                      t4[indent]:=Ofset2_f+g;
                      t5[indent]:=Ofset2_g-f;
                      t6[indent]:=Ofset2_f-g;
                      t7[indent]:=Ofset1_g-f;
                      t7[indent]:=Ofset1_f-g;

                      indent:=indent+1;
                                       end;



for c:=0 to 500  do Begin;
                    indent:=1;
                    for f:=0 to 60 do
                    for g:=f to 60 do Begin;
                                cou:=(f+g+g)*(f+f+g+c+c+c);

                                      Vga_Ecran[t1[indent]]:=Cou;
                                      Vga_Ecran[t2[indent]]:=cou;
                                      Vga_Ecran[t3[indent]]:=Cou;
                                      Vga_Ecran[t4[indent]]:=Cou;
                                      Vga_Ecran[t5[indent]]:=Cou;
                                      Vga_Ecran[t6[indent]]:=cou;
                                      Vga_Ecran[t7[indent]]:=Cou;
                                      Vga_Ecran[t8[indent]]:=Cou;

                                      indent:=indent+1;
                                      end;

                    end;



VGA.TextMode;

END.





{for c:=0 to 100  do Begin;
                    for f:=0 to 99 do
                    for g:=f to 99 do Begin;
                                cou:=(f+g+g)*(f+f+g+c+c+f+f);
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

                    end;}