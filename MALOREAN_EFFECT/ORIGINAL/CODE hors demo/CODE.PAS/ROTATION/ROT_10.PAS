USES CGraph,Crt,gest_dac;

Const Max=99;
      Max2=Max div 2;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     VGA      : TGraphVga;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
VGA.GraphMode;
put_dac(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=5*Xe;
                   Ty[Xe]:=ROUND(150*Cos(Xe/10));
                   End;


For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]-Ty[Ye];
                   V[t[Ye]+Xe]:=Cou;
                   V[t[Xe]+Ye]:=cou;
                   V[-t[Ye]+Xe]:=Cou;
                   V[-t[Xe]+Ye]:=Cou;
                   V[-t[Ye]-Xe]:=Cou;
                   V[-t[Xe]-Ye]:=cou;
                   V[t[Ye]-Xe]:=Cou;
                   V[t[Xe]-Ye]:=Cou;
                   end;
                   end;

repeat; until keypressed;
END.