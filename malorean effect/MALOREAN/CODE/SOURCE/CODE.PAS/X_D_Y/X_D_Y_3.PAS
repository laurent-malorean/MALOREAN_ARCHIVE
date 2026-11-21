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
                   cOU:=(f*f*f+g*g*g) DIV 500 + (f*f+g*g) DIV 1 +f*g;
                   Vga_Ecran[t[g]+f]:=Cou;
                   end;
REPEAT; UNTIL KEYPRESSED;
VGA.TextMode;

END.