Uses Gest_Byte,GEST_GRAPH,GEST_DAC,CRT;

VAR   Xe,Ye,Ze : Word;
      Dx,Dy    : ARRAY [0..319] Of Integer;
      Delta    : Integer;
      Color    : byte;
      Carre    : Array [0..320] of Longint;

BEGIN
GraphMode;
PUT_DAC(GEST_DAC.BLUE);
For xe:=0 to 320 do carre[Xe]:=Xe*Xe;
For Xe:=1 to 319 Do For Ye:=1 to 199 Do Begin;
Color:=round(5*(xe*Xe+Ye*Ye)/exp(arctan(ye/xe)));
Vga[Mul320[Ye]+Xe]:=Color;
end;

Delay(5000);
END.