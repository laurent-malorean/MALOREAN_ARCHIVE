Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       carle    : byte;
       cc : word;
       a,b,ap,bp : word;
       res : word;
       nbiter: byte;

Begin;
Vga.GraphMode;
c:=0;
loadpal ('e:\tp\pal\blue.pal');
for cc:=0 to 50000  do Begin;
                   c:=c+1; {faire varier c 10 100 1000 change motif}
                    for f:=1 to 99 do
                    for g:=f to 99 do Begin;
                    a:=f and g;
                    b:=f-g;
                    if b=0 then b:=a;
                    ap:=a;
                    bp:=b;
                    a:=ap*ap+ (c*bp div 4);
                    b:=ap div bp;
                    res:=a + b;

                                      cou:= res;
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