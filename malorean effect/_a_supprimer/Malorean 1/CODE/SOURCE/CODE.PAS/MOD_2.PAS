USES Gest_Graph,Crt,dac_code,dac_frac;

VAR  Xe,Ye      : WORD;
     cou : word;
     Log : Array [1..319] of Real;

BEGIN;
GraphMode;
put_dac(Blue);
for Xe:=1 to 319 do Log[Xe]:=Ln(Xe);

For xe:=1 to 319 Do Begin;
For Ye:=1 TO 199 DO Begin;
                    cou:=Round(Xe*Log[Ye]) xor round(Ye*Log[Xe]);
                    Vga[+Mul320[Ye]+Xe]:=Cou;
                    end;
                    end;

repeat; until keypressed;
END.