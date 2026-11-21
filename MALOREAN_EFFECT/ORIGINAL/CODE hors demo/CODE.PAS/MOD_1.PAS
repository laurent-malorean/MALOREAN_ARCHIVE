USES Gest_Graph,Crt,dac_code,dac_frac;

VAR  Xe,Ye      : WORD;
     cou : word;

BEGIN;
GraphMode;
put_dac(Blue);

For xe:=0 to 319 Do  Begin;
For Ye:=0 TO 199 DO Begin;
                    cou:=Xe mod 40 + Ye Mod 40;
                    Vga[+Mul320[Ye]+Xe]:=Cou;
                   end;
                   end;

repeat; until keypressed;
END.