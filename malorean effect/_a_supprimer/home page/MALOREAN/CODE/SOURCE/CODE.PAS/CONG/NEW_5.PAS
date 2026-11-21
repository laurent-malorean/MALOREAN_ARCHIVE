Uses CGraph,crt,gest_dac;
Var    VGA      : TGraphVga;
       F,G      : word;
       CA       : byte;
       OFS      : WORD;

BEGIN; Vga.GraphMode;  put_dac (blue);
       For G:=1 to 199 do BEGIN;
                          OFS:=T[G];
                          For F:=1 to 250 do Begin;
                                             ca:=f*f+g*g;
                                             INC (OFS);
                                             Vga_Ecran[OFS]:=Ca;
                                             END;
                          END;
        REPEAT;UNTIL KEYPRESSED;  VGA.TextMode;
END.