Uses CGraph,crt,dac_code,dac_frac;

Const Max=99;
max2=max div 2;

Var    VGA      : TGraphVga;
       xe       : word;
       ye       : word;
       c        : word ;
       cou      : Byte;
       carle    : byte;


Begin;
Vga.GraphMode;

put_dac (volcano);
for c:=0 to 500  do Begin;
                    for Xe:=0 to Max2 do
                    for Ye:=1 to Xe do Begin;
                                            {(f-g)*(g*c)*(c-f) and c ou g ou f}
                                      cou:= (c-Xe*Ye)  +Ye*c;
                                      cou:=xe+ye+c;
                                      Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                                      Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                                      Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                                      Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                                      Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                                      Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                                      Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                                      Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;

                                      end;
                    for Xe:=Max2 to Max do
                    for Ye:=1 to Xe do Begin;
                                            {(f-g)*(g*c)*(c-f) and c ou g ou f}
                                      cou:= (c-Xe*Ye)  +Ye*c;
                                      Vga_Ecran[t[Ye+100]+Xe+160]:=Cou;
                                      Vga_Ecran[t[Xe+100]+Ye+160]:=cou;
                                      Vga_Ecran[t[100-Ye]+Xe+160]:=Cou;
                                      Vga_Ecran[t[100-Xe]+160+Ye]:=Cou;
                                      Vga_Ecran[t[100-Ye]+-Xe+160]:=Cou;
                                      Vga_Ecran[t[-Xe+100]-Ye+160]:=cou;
                                      Vga_Ecran[t[100+Ye]-Xe+160]:=Cou;
                                      Vga_Ecran[t[100+Xe]+160-Ye]:=Cou;

                                      end;



                    end;
VGA.TextMode;

END.