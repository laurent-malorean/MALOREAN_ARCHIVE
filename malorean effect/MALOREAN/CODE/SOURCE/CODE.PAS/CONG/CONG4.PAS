Uses CGraph,crt,GEST_DAC;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       carle    : byte;
       ca : byte;

Begin;
Vga.GraphMode;

PUT_DAC (PAL1);
for c:=0 to 500  do Begin;
                    for f:=1 to 99 do
                    for g:=f to 99 do Begin;
                    ca:=1;
                    repeat;
                    inc(ca);
                    until (f mod g =ca) or (ca=250);


                                      cou:= ca ;
                                      Vga_Ecran[t[g+100]+f+160]:=Cou;
                                      Vga_Ecran[t[f+100]+g+160]:=cou;
                                      Vga_Ecran[t[100-g]+f+160]:=Cou;
                                      Vga_Ecran[t[100-f]+160+g]:=Cou;
                                      Vga_Ecran[t[100-g]+-f+160]:=Cou;
                                      Vga_Ecran[t[-f+100]-g+160]:=cou;
                                      Vga_Ecran[t[100+g]-f+160]:=Cou;
                                      Vga_Ecran[t[100+f]+160-g]:=Cou;



                                      end;
                    end;
VGA.TextMode;

END.