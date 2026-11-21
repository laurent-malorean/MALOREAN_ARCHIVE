Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       carle    : byte;


Begin;
Vga.GraphMode;

loadpal ('E:\tp\pal\blue.pal');
for c:=0 to 500  do Begin;
                    for f:=0 to 99 do
                    for g:=f to 99 do Begin;
                                            {(f-g)*(g*c)*(c-f) and c ou g ou f}
                                      cou:= (c*c*c-f*g)+g*c;
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