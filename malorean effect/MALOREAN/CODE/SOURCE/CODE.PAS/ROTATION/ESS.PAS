USES CGraph,Crt,GEST_DAC;

Const Max=99;
      Max2=Max div 2;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..330] Of BYTE;
     InterX,InterY    : Byte;
     VGA      : TGraphVga;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
VGA.GraphMode;
PUT_DAC(Volcano);
For Xe:=0 to 330 Do Begin;
                   Tx[Xe]:=Round(150*Sin(Xe/10));
                   Ty[Xe]:=ROUND(150*Cos(Xe/10));
                   End;


For xe:=0 to 319 Do  Begin;
For Ye:=0 TO 199 DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   VGA_ECRAN[t[Ye]+Xe]:=Cou;
                   end;
                   end;
repeat; until keypressed;
END.