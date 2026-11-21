Uses CGraph,crt,GEST_DAC;
Var    VGA      : TGraphVga;
       F,G      : word;
       CA       : byte;
       OFS      : WORD;

BEGIN; Vga.GraphMode;   PUT_DAC(pal1);
       For G:=1 to 200 do BEGIN;
                          OFS:=T[G];
                          For F:=1 to 250 do Begin;
                                             ca:=0;
                                             repeat;
                                             inc(ca);
                                             until (f MOD  g =ca) or (ca=250);
                                             Vga_Ecran[OFS+f]:=Ca;
                                             END;
                          END;
        REPEAT;UNTIL KEYPRESSED;  VGA.TextMode;
END.