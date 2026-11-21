USES GEST_GRAPH,DAC_CODE,DAC_FRAC,CRT,VARIABLE;

VAR   Xe,Ye,Ze : Word;
      Dx,Dy    : ARRAY [0..319] Of Integer;
      Delta    : Word;
      Cou      : Byte;




BEGIN
GraphMode;
PUT_DAC(DAC_FRAC.Blue);

For Ze:=1 to 500 Do Begin;
For Xe:=0 to 319 Do
For Ye:=0 to 199 Do Begin;
                    Vga[Mul320[Ye]+Xe]:=(Xe or Ye)*Ze shr 4;
                    end;

END; {for ze}

END.