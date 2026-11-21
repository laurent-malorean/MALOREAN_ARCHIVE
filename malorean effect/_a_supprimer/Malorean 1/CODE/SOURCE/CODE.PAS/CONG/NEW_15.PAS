Uses CGraph,crt,GEST_DAC;
Var    VGA      : TGraphVga;
       F,G      : word;
       CA       : byte;
       OFS      : WORD;

BEGIN; Vga.GraphMode;  put_dac (BLUE);
       For G:=1 to 199 do BEGIN;
                          OFS:=T[G];
                          For F:=1 to 250 do Begin;
                                             ca:=0;
                                             repeat;
                                             inc(ca);
                          until ((g*g-f*f) MOD g< CA) or (ca=250);
                                             Vga_Ecran[OFS+f]:=Ca;
                                             END;
                          END;
        REPEAT;UNTIL KEYPRESSED;  VGA.TextMode;
END.