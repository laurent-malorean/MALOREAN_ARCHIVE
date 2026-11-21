Uses CGraph,crt,gest_dac;
type t1 = ARRAY [1..99,1..99] Of LongInt;

Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       carle    : byte;
       cc : word;
       B : ARRAY [1..99,1..99] Of integer;
       A : ARRAY [1..99,1..99] Of Word;

Begin;
Vga.GraphMode;
c:=0;
put_dac (pal1);

for f:=1 to 99 do for g:=f to 99 do b[f,g]:=f*f-g*g+2*f*g;
for f:=1 to 99 do for g:=f to 99 do A[f,g]:=f*f+g*g;

for cc:=1 to 50000  do Begin;
                   c:=c+1;

                    for f:=1 to 99 do
                    for g:=f to 99 do Begin;
                                      cou:=(a[F,G]*c ) div b[f,g];
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