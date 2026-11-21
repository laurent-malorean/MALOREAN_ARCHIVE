USES GEST_GRAPH,DAC_CODE,DAC_FRAC,CRT;

VAR   Xe,Ye,Ze : Word;
      Dx,Dy    : ARRAY [0..319] Of Integer;
      Delta    : Integer;
      Cou      : Byte;




BEGIN
GraphMode;
PUT_DAC(DAc_FRAC.BLUE);


For Ze:=1 to 500 Do Begin;


For Xe:=0 to 320 Do
For Ye:=0 to 199 Do Begin;
                    Delta:=0;
                    Repeat;
                    Inc(Delta);
                    Until ((Xe AND Delta)=Ye) or (Delta>100);
                    Vga[Mul320[Ye]+Xe]:=Delta;

                    end;

END; {for ze}

END.