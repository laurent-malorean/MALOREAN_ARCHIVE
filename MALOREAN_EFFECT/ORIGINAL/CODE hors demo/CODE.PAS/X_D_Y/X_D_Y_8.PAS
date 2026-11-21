Uses CGraph,crt,gest_dac;
Var    VGA      : TGraphVga;
       f        : word;
       g        : word;
       c        : word ;
       cou      : Byte;
       carle    : byte;
       ca : byte;

Begin;
Vga.GraphMode;
put_dac (BLUE);
COU:=1;
FOR C:=1 TO 200 DO BEGIN;
for f:=1 to 99 do
for g:=F to 99 do Begin;
                   COU:=(F-C) AND G;
                   Vga_Ecran[t[g+100]+f+160]:=Cou;
                   Vga_Ecran[t[f+100]+g+160]:=cou;
                   Vga_Ecran[t[100-g]+f+160]:=Cou;
                   Vga_Ecran[t[100-f]+160+g]:=Cou;
                   Vga_Ecran[t[100-g]+-f+160]:=Cou;
                   Vga_Ecran[t[-f+100]-g+160]:=cou;
                   Vga_Ecran[t[100+g]-f+160]:=Cou;
                   Vga_Ecran[t[100+f]+160-g]:=Cou;

                   end;
                   END;
REPEAT; UNTIL KEYPRESSED;
VGA.TextMode;

END.