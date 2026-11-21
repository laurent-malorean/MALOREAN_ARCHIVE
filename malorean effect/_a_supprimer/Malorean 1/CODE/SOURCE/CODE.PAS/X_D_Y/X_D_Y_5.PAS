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
for f:=1 to 319 do
for g:=1 to 199 do Begin;
                   COU:=F AND G;
                   Vga_Ecran[t[g]+f]:=Cou;
                   end;
REPEAT; UNTIL KEYPRESSED;
VGA.TextMode;

END.