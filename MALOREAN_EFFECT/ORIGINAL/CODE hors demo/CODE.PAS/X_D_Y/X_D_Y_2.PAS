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

PUT_DAC (BLUE);
for f:=1 to 319 do
for g:=1 to 199 do Begin;
                   cOU:=100*F DIV G;
                   Vga_Ecran[t[g]+f]:=Cou;
                   end;
REPEAT; UNTIL KEYPRESSED;
VGA.TextMode;

END.