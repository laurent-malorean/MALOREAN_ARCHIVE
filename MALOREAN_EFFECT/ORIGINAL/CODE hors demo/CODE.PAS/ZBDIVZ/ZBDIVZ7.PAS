Uses CGraph,crt,GEST_DAC;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       Fcarre   : Word;
       carle    : byte;
       cc : word;
       B : ARRAY [1..99,1..99] Of Integer;

Begin;
Vga.GraphMode;
c:=0;
put_dac (pal1);
for f:=1 to 99 do For g:=1 to f do  b[f,g]:=f*f+g*g-2*f*g;


for cc:=1 to 50000  do Begin;
                   c:=c+1; {faire varier c 10 100 1000 change motif}

for f:=1 to 99 do Begin;
                   Fcarre:=f*f;
 for g:=1 to f do Begin;
                    If B[F,g]<>0 then  cou:=( (fcarre-g*g)*c) div b[f,g];
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
                    end;
VGA.TextMode;

END.