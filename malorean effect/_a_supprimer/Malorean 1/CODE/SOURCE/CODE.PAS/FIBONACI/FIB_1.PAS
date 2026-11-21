USES Gest_Graph,Crt,dac_code,dac_frac;

Const MAx = 700;

VAR  Xe,Ye      : WORD;
     cou        : word;
     FIB1       : Array [0..Max] Of LongInt;
     FIB2       : Array [0..Max] Of LongInt;
     Z          : Word;

BEGIN; GraphMode; put_dac(Blue);

For Z:=1 to 100 do Begin;

Fib1[0]:=3; Fib1[1]:=4;
For Xe:=2 To Max Do Fib1[Xe]:=Fib1[Xe-1]+Fib1[Xe-2];
Fib2[0]:=+3;         Fib2[1]:=-1;
For Xe:=2 To Max Do Fib2[Xe]:=Fib2[Xe-1]+Fib2[Xe-2];

For xe:=1 to 319 Do Begin;
For Ye:=1 TO 199 DO Begin;
                    cou:=Fib1[Xe+Ye]+Fib2[Ye-Xe];
                    Vga[Mul320[Ye]+Xe]:=Cou;
                    end;
                    end;
end;
Repeat; Until Keypressed;

END.