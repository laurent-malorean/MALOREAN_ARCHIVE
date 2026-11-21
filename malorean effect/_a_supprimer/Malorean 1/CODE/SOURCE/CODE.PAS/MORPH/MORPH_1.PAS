{$S-}

Uses GEST_GRAPH,DAC_CODE,DAC_FRAC,CRT;

procedure rot_9;
VAR
     Xe,Ye,Z    : WORD;
     Tx,Ty    : ARRAY[0..99] Of BYTE;
     cou      : word;
     V        : ARRAY [0..64000] Of Byte  ABSOLUTE $A000:32160;
     Inter    : ShortInt;


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

Delay(1000);
For Z:=1 to 400 Do Begin;
For xe:=0 to 99 Do  Begin;
For Ye:=0 TO Xe DO Begin;
                   Cou:=V[Mul320[Ye]+Xe];
                   Inter:=(inter-Random(6)-3) Shr 1;
                   V[+Mul320[Ye]+Xe]:=Cou+Inter;
                   V[+Mul320[Xe]+Ye]:=cou+Inter;
                   V[-Mul320[Ye]+Xe]:=Cou+Inter;
                   V[-Mul320[Xe]+Ye]:=Cou+Inter;
                   V[-Mul320[Ye]-Xe]:=Cou+Inter;
                   V[-Mul320[Xe]-Ye]:=cou+Inter;
                   V[+Mul320[Ye]-Xe]:=Cou+Inter;
                   V[+Mul320[Xe]-Ye]:=Cou+Inter;
                   end;
                   end;

end;
END;



BEGIN;
GraphMode;
cls(0); rot_9;
END.
