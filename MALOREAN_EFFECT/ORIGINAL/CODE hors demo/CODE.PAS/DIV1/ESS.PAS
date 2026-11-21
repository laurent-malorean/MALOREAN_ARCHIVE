Uses Gest_Byte,GEST_GRAPH,GEST_DAC,CRT;

VAR   Xe,Ye,Ze : Word;
      Dx,Dy    : ARRAY [0..319] Of Integer;
      Delta    : Integer;


BEGIN
GraphMode;
PUT_DAC(GEST_DAC.BLUE);


For Xe:=0 to 319 Do For Ye:=0 to 199 Do Vga[Mul320[Ye]+Xe]:=
(Xe and (Ye-Xe)) + (Xe and (Ye+Xe));

Delay(5000);
END.