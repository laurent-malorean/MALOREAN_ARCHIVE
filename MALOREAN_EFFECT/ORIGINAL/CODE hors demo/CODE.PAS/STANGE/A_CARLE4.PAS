Uses CGraph,crt,dac_code,dac_frac;
Var    VGA      : TGraphVga;
       f        : byte;
       g        : byte;
       c        : word ;
       cou      : Byte;
       seg_mul_plus : Word;
       ofs_mul_plus : Word;
       C_Moin_F : byte;
       foi : byte;

       carle    : byte;
       h  : Byte;
       VDI : word;
       hh : word;

       MUL_Plus : array [0..199] of Word;
       MUL_Moin : array [0..199] of Word;

 ma,mb,mc,md : WORD;
Begin;
Vga.GraphMode;
Seg_Mul_Plus:=Seg(Mul_Plus);
Seg_Mul_Plus:=ofs(Mul_Plus);

for f:=0 to 99 do MUL_Plus[f]:=(f+100)*320+160;
for f:=0 to 199 do MUL_Moin[f]:=(100-f)*320+160;
put_dac (volcano);
for c:=0 to 255  do Begin;
                    for f:=0 to 99 do Begin;
                                     c_moin_f:=(c-f);
                                     foi:=c_moin_f*f;
                                     Mb:=Mul_Plus[f];
                                     MD:=Mul_Moin[f];

                    for g:=f to 99 do Begin;
                                     Cou:=foi + c;
                                     foi:=foi+c_moin_f;
                                     ma:=Mul_Plus[g];
                                     MC:=Mul_Moin[g];

                                     Vga_Ecran[Ma+f]:=Cou;
                                     Vga_Ecran[Ma-f]:=Cou;
                                     Vga_Ecran[Mb+g]:=cou;
                                     Vga_Ecran[Mb-g]:=Cou;
                                     Vga_Ecran[Mc+f]:=Cou;
                                     Vga_Ecran[Mc-f]:=Cou;
                                     Vga_Ecran[Md+g]:=Cou;
                                     Vga_Ecran[Md-g]:=cou;

                                      end;
                                      end;
                    end;
VGA.TextMode;

END.