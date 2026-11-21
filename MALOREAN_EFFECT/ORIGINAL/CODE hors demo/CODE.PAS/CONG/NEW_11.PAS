Uses CGraph,crt,GEST_DAC;
Var    VGA      : TGraphVga;
       F,G      : word;
       CA       : byte;
       OFS      : WORD;
       S        : WORD;
       CARRE    : ARRAY[0..5000] OF LongInt;


BEGIN; Vga.GraphMode;  PUT_DAC (blue);
       For F:=1 To 5000 Do CARRE[F]:=F*F;
       For S:=1 To 500 Do Begin;
       For G:=1 to 150 do BEGIN;
                          OFS:=T[G];
                          For F:=1 to 150 do Begin;
ca:=(CARRE[S+f] MOD( CARRE[f+g]+1) )+ CARRE[g+s] ;
                                             INC (OFS);
                                             Vga_Ecran[OFS]:=Ca;
                                             END;
                          END;
                          End;
        REPEAT;UNTIL KEYPRESSED;  VGA.TextMode;
END.