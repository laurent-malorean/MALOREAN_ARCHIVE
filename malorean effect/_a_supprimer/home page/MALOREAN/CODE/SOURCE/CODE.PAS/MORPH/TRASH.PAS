{$S-}

Uses CRT,DOS,GEST_GRAPH,DAC_CODE,DAC_FRAC;

CONST A=99;
Const Max=99;
      Max2=Max div 2;

VAR F1 : Word;

{***************************************************************************}
procedure rot_9;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
put_dac(VOLCANO);
For Xe:=0 to 99 Do Begin; Tx[Xe]:=5*Xe;
                          Ty[Xe]:=ROUND(150*Cos(Xe/10));
                          End;

For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   V[Mul320[Ye]+Xe]:=Cou;
                   V[Mul320[Xe]+Ye]:=cou;
                   V[-Mul320[Ye]+Xe]:=Cou;
                   V[-Mul320[Xe]+Ye]:=Cou;
                   V[-Mul320[Ye]-Xe]:=Cou;
                   V[-Mul320[Xe]-Ye]:=cou;
                   V[Mul320[Ye]-Xe]:=Cou;
                   V[Mul320[Xe]-Ye]:=Cou;
                   end;
                   end;

END;

{***************************************************************************}
procedure rot_14;
VAR
     Xe,Ye    : WORD;
     X        : Word;
     F        : WORD;
     P1,P2    : Word;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     InterX,InterY    : Byte;
     cou : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;

BEGIN;
PUT_DAC(Volcano);
For Xe:=0 to 99 Do Begin;
                   Tx[Xe]:=Round(150*Sin(Xe/10));
                   Ty[Xe]:=ROUND(150*Cos(Xe/10));
                   End;


For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   cou:=Tx[Xe]+Ty[Ye];
                   V[Mul320[Ye]+Xe]:=Cou;
                   V[Mul320[Xe]+Ye]:=cou;
                   V[-Mul320[Ye]+Xe]:=Cou;
                   V[-Mul320[Xe]+Ye]:=Cou;
                   V[-Mul320[Ye]-Xe]:=Cou;
                   V[-Mul320[Xe]-Ye]:=cou;
                   V[Mul320[Ye]-Xe]:=Cou;
                   V[Mul320[Xe]-Ye]:=Cou;
                   end;
                   end;
END;


BEGIN;
GraphMode;




cls(0); rot_9;  delay(2000);
        rot_14; delay(2000);
END.
